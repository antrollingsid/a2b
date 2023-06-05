import 'package:a2b/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:async';

import 'package:geolocator/geolocator.dart' as geo;
import 'package:permission_handler/permission_handler.dart';


class AcceptedOfferView extends StatefulWidget {
  const AcceptedOfferView({
    super.key,
    required this.name,
    required this.photoUrl,
    required this.date,
    required this.from,
    required this.to,
  });
  final String name;
  final String photoUrl;
  final String date;
  final String from;
  final String to;

  @override
  State<AcceptedOfferView> createState() => _AcceptedOfferViewState();
}

class _AcceptedOfferViewState extends State<AcceptedOfferView> {
  final geo.Geolocator geolocator = geo.Geolocator();
  StreamSubscription<geo.Position>? _locationSubscription;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 333,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Container(
          decoration: BoxDecoration(
              color: context.secondaryHeaderColor,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Implement the logic to show the image in full size
                              // For example, you can use a Dialog or a separate screen to display the image.
                              showDialog(
                                context: context,
                                builder: (_) => Dialog(
                                  child: Image.network(
                                    widget.photoUrl,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            },
                            child: ClipOval(
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(widget.photoUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            widget.name,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: context.scaffoldBackgroundColor),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                language.date,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context.scaffoldBackgroundColor),
                              ),
                              Text(
                                widget.date,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context.scaffoldBackgroundColor),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                language.from,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context.scaffoldBackgroundColor),
                              ),
                              Text(
                                widget.from,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context.scaffoldBackgroundColor),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                language.to,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context.scaffoldBackgroundColor),
                              ),
                              Text(
                                widget.to,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context.scaffoldBackgroundColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              _getLocation();
                            },
                            child: Text('Picked'),
                          ),
                          TextButton(
                            onPressed: () {
                              _listenLocation();
                            },
                            child: Text('On the way'),
                          ),
                          TextButton(
                            onPressed: () {
                              _stopListening();
                            },
                            child: Text('delivered'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 23,
                  child: Center(
                      child: Icon(
                    Icons.arrow_forward_sharp,
                    color: Colors.white70,
                  )),
                )
              ],
            ),
          ),
        ),
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
