import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';

import 'livemap.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
    // this is for bg off the app???
    // geolocator.enableBackgroundMode(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('live location tracker'),
        backgroundColor: context.primaryColor,
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              _getLocation();
            },
            child: const Text('pickup'),
          ),
          TextButton(
            onPressed: () {
              _listenLocation();
            },
            child: const Text('on the way'),
          ),
          TextButton(
            onPressed: () {
              _stopListening();
            },
            child: const Text('shipped'),
          ),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('location').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
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
                          const SizedBox(width: 20),
                          Text(snapshot.data!.docs[index]['longitude']
                              .toString()),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.directions),
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
      final geo.Position positionResult =
          await geo.Geolocator.getCurrentPosition();
      await FirebaseFirestore.instance.collection('location').doc('user1').set(
        {
          'latitude': positionResult.latitude,
          'longitude': positionResult.longitude,
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
