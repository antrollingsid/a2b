import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:permission_handler/permission_handler.dart';

import 'livemap.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final geo.Geolocator geolocator = geo.Geolocator();
  StreamSubscription<geo.Position>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    // geolocator.changeSettings(
    //   interval: 300,
    //   accuracy: geo.LocationAccuracy.high,
    // );
    // geolocator.enableBackgroundMode(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('live location tracker'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              _getLocation();
            },
            child: Text('add my location'),
          ),
          TextButton(
            onPressed: () {
              _listenLocation();
            },
            child: Text('enable live location'),
          ),
          TextButton(
            onPressed: () {
              _stopListening();
            },
            child: Text('stop live location'),
          ),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('location').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title:
                          Text(snapshot.data!.docs[index]['name'].toString()),
                      subtitle: Row(
                        children: [
                          Text(snapshot.data!.docs[index]['latitude']
                              .toString()),
                          SizedBox(width: 20),
                          Text(snapshot.data!.docs[index]['longitude']
                              .toString()),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.directions),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  MyMap1(snapshot.data!.docs[index].id),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _getLocation() async {
    try {
      final geo.Position _positionResult =
          await geo.Geolocator.getCurrentPosition();
      await FirebaseFirestore.instance.collection('location').doc('user1').set(
        {
          'latitude': _positionResult.latitude,
          'longitude': _positionResult.longitude,
          'name': 'john',
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> _listenLocation() async {
    _locationSubscription =
        geo.Geolocator.getPositionStream().handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((geo.Position currentPosition) async {
      await FirebaseFirestore.instance.collection('location').doc('user1').set(
        {
          'latitude': currentPosition.latitude,
          'longitude': currentPosition.longitude,
          'name': 'john',
        },
        SetOptions(merge: true),
      );
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
