// ignore_for_file: unused_import

import 'dart:async';

import 'package:a2b/controllers/location_text_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../../../Components/widgets/app_bar_buttons.dart';
import '../../../main/utils/Constants.dart';

const darkMapStyle = 'assets/json/dark_mode_style.json';

class LiveTracking extends StatefulWidget {
  const LiveTracking({Key? key}) : super(key: key);

  @override
  State<LiveTracking> createState() => _LiveTrackingState();
}

class _LiveTrackingState extends State<LiveTracking> {
  final Completer<GoogleMapController> _controllerCompleter = Completer();

  static const LatLng _sourceLocation = LatLng(35.151649, 33.904888);
  static const LatLng _destination = LatLng(35.146837, 33.908643);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  StreamSubscription<Position>? positionStreamSubscription;
  Timer? cameraUpdateTimer; // Added timer variable

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .catchError((error) async {
      await Geolocator.requestPermission();
      print("ERROR: $error");
    });
    return await Geolocator.getCurrentPosition();
  }

  void startLocationUpdates() {
    positionStreamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      print('${position.latitude} ${position.longitude}');

      setState(() {
        currentLocation = LocationData.fromMap({
          'latitude': position.latitude,
          'longitude': position.longitude,
        });
      });
    });
  }

  void stopLocationUpdates() {
    positionStreamSubscription?.cancel();
    setState(() {
      positionStreamSubscription = null;
    });
  }

  void startCameraUpdates() {
    cameraUpdateTimer =
        Timer.periodic(const Duration(milliseconds: 300), (timer) {
      final cameraPosition = CameraPosition(
        target: LatLng(
          currentLocation?.latitude ?? _sourceLocation.latitude,
          currentLocation?.longitude ?? _sourceLocation.longitude,
        ),
        zoom: 16,
      );

      final controller = _controllerCompleter.future;
      controller.then((GoogleMapController controller) {
        controller
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      });
    });
  }

  void stopCameraUpdates() {
    cameraUpdateTimer?.cancel();
    cameraUpdateTimer = null;
  }

  void getPolyPoints() async {
    try {
      PolylinePoints polylinePoints = PolylinePoints();

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleMapAPIKey,
        PointLatLng(_sourceLocation.latitude, _sourceLocation.longitude),
        PointLatLng(_destination.latitude, _destination.longitude),
      );
      if (result.points.isNotEmpty) {
        polylineCoordinates.clear();

        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
        setState(() {});
      } else {
        print("No polyline points found");
      }
    } catch (e) {
      print("Error getting polyline points: $e");
    }
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/icons/Pin_source.png")
        .then((icon) {
      sourceIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/icons/Pin_destination.png")
        .then((icon) {
      destinationIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/icons/Pin_current_location.png")
        .then((icon) {
      currentLocationIcon = icon;
    });
  }

  @override
  void initState() {
    // setCustomMarkerIcon();
    startLocationUpdates();
    startCameraUpdates();
    getPolyPoints();
    super.initState();
  }

  // @override
  // void dispose() {
  //   stopLocationUpdates();
  //   stopCameraUpdates();
  //   // super.dispose();
  // }
  // @override
  // void dispose() {
  //   positionStreamSubscription?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // final locationController = Get.put(LocationTextController());

    return Scaffold(
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'Live Tracking',
          isActionVisible: true,
          isLeadingVisible: true,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 374,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      currentLocation?.latitude ?? _sourceLocation.latitude,
                      currentLocation?.longitude ?? _sourceLocation.longitude,
                    ),
                    zoom: 16,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controllerCompleter.complete(controller);

                    // String value = DefaultAssetBundle.of(context).loadString('assets/json/map-dark-mode-style.json');
                    // controller.setMapStyle(value);
                  },
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  myLocationEnabled: true,
                  compassEnabled: true,
                  mapType: MapType.normal,
                  mapToolbarEnabled: true,
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId("route"),
                      points: polylineCoordinates,
                      color: context.primaryColor,
                      width: 6,
                    ),
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId("currentLocation"),
                      // icon: currentLocationIcon,
                      position: LatLng(
                        currentLocation?.latitude ?? _sourceLocation.latitude,
                        currentLocation?.longitude ?? _sourceLocation.longitude,
                      ),
                    ),
                    const Marker(
                      markerId: MarkerId("source"),
                      // icon: sourceIcon,
                      position: _sourceLocation,
                    ),
                    const Marker(
                      markerId: MarkerId("destination"),
                      // icon: destinationIcon,
                      position: _destination,
                    ),
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                stopLocationUpdates;
              },
              child: const Text("stop"),
            ),
            ElevatedButton(
              onPressed: () {
                if (polylineCoordinates.isEmpty) {
                  print('polylineCoordinates is empty');
                } else {
                  for (LatLng coordinate in polylineCoordinates) {
                    print(
                        "Latitude: ${coordinate.latitude}, Longitude: ${coordinate.longitude}");
                  }
                }
              },
              child: Text('Print Coordinates'),
            ),
          ],
        ),
      ),
    );
  }
}
