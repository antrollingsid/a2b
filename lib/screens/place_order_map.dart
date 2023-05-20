import 'dart:async';

import 'package:a2b/controllers/location_text_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../main/utils/allConstants.dart';
import 'package:flutter/material.dart';
import '../../Components/widgets/app_bar_buttons.dart';
import 'package:location/location.dart';
import 'package:location/location.dart' as loc;
//yandix api maps check ?????
import 'my_map.dart';

const darkMapStyle = 'assets/json/dark_mode_style.json';

class PlaceOrderMap extends StatefulWidget {
  const PlaceOrderMap({super.key});

  @override
  State<PlaceOrderMap> createState() => _PlaceOrderMapState();
}

class _PlaceOrderMapState extends State<PlaceOrderMap> {
  final Completer<GoogleMapController> _controllers = Completer();
  final loc.Location location = loc.Location();

  StreamSubscription<loc.LocationData>? _locationSubscription;
  static const LatLng _sourceLocation = LatLng(
    35.151649,
    33.904888,
  );
  static const LatLng _destination = LatLng(
    35.146837,
    33.908643,
  );
  static const CameraPosition _kInitialPosition =
      CameraPosition(target: _sourceLocation, zoom: 15.0, tilt: 0, bearing: 0);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  void getLocation() {
    getUserCurrentLocation().then((position) async {
      print(position.latitude.toString() + " " + position.longitude.toString());

      setState(() {
        currentLocation = LocationData.fromMap({
          "latitude": position.latitude,
          "longitude": position.longitude,
        });
      });

      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 16,
      );

      final GoogleMapController controller = await _controllers.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    });
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
        result.points.forEach(
          (PointLatLng point) => polylineCoordinates.add(
            LatLng(point.latitude, point.longitude),
          ),
        );
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    try {
      getLocation();
    } catch (e) {
      print(e);
    }
    getPolyPoints();
    super.initState();
  }

  late GoogleMapController _controller;

  Future<void> onMapCreated(GoogleMapController controller) async {
    _controllers.complete(controller);
    _controller = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/json/map-dark-mode-style.json');
    _controller.setMapStyle(value);
  }

// _controller.setMapStyle(DefaultAssetBundle.of(context)
  // .loadString('assets/json/map-dark-mode-style.json'));
  @override
  Widget build(BuildContext context) {
    final locationcontroller = Get.put(LocationTextController());

    return Scaffold(
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'Place Order',
          isActionVisible: true,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Container(
              // width: 333,
              height: 374,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: GoogleMap(
                  // onMapCreated: (GoogleMapController controller) {
                  //   _controller.complete(controller);
                  // },
                  initialCameraPosition: _kInitialPosition,
                  onMapCreated: onMapCreated,
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
                    const Marker(
                        markerId: MarkerId("source"),
                        position: _sourceLocation),
                    const Marker(
                        markerId: MarkerId("destination"),
                        position: _destination),
                  },
                ),
              ),
            ),
            ElevatedButton(onPressed: getLocation, child: const Text("data")),
            ElevatedButton(
                onPressed: () {
                  _getLocation();
                },
                child: const Text("add my location")),
            ElevatedButton(
                onPressed: () {
                  _listenLocation();
                },
                child: const Text("enable live locattion")),
            ElevatedButton(
                onPressed: () {
                  _stopListening();
                },
                child: const Text("stop live location")),

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
                            SizedBox(
                              width: 20,
                            ),
                            Text(snapshot.data!.docs[index]['longitude']
                                .toString()),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.directions),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    MyMap(snapshot.data!.docs[index].id)));
                          },
                        ),
                      );
                    });
              },
            )),
            // CustomTextfield(
            //     isPassword: false,
            //     hintText: 'Where from?',
            //     mycontroller: locationcontroller.from,
            //     width: 333),
            // CustomTextfield(
            //     isPassword: false,
            //     hintText: 'Where to?',
            //     mycontroller: locationcontroller.to,
            //     width: 333),
            // CustomTextfield(
            //     isPassword: false,
            //     hintText: 'receiver\'s name',
            //     mycontroller: locationcontroller.name,
            //     width: 333),
            // SizedBox(
            //   width: 333,
            //   child: IntlPhoneField(
            //     showCountryFlag: false,
            //     controller: locationcontroller.number,
            //     decoration: InputDecoration(
            //       prefixIcon: null,
            //       border: myinputborder(),
            //       enabledBorder: myinputborder(), //enabled border
            //       focusedBorder: myfocusborder(),
            //     ),
            //     initialCountryCode: 'TR',
            //     onChanged: (phone) {
            //       print(phone.completeNumber);
            //     },
            //   ),
            // ),
            // CustomBtn(
            //   textonbtn: 'Next',
            //   onPress: () => Get.to(() => const ConfirmOrder()),
            //   primary: true,
            // ),
          ],
        ),
      ),
    );
  }

  _getLocation() async {
    try {
      _requestPermission();
      Location location = Location();
      // if (await location.hasPermission()) {
      final LocationData pos = await location.getLocation();

      print(pos.runtimeType);
      // _lastMapPosition = pos;

      // } else {
      //     // await location.requestPermission();
      // }
      // final loc.LocationData _locationResult = await location.getLocation();
      // await FirebaseFirestore.instance.collection('location').doc('user1').set({
      //   'latitude': _locationResult.latitude,
      //   'longitude': _locationResult.longitude,
      //   'name': 'john'
      // }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance.collection('location').doc('user1').set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': 'john'
      }, SetOptions(merge: true));
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

OutlineInputBorder myinputborder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
      borderSide: BorderSide(
        color: AppColors.textFaded,
        width: 1,
      ));
}

OutlineInputBorder myfocusborder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
      borderSide: BorderSide(
        color: AppColors.primary,
        width: 1,
      ));
}
