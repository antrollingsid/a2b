import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/material.dart';
import '../../Components/widgets/app_bar_buttons.dart';
import '../main/utils/constants.dart';

const darkMapStyle = 'assets/json/dark_mode_style.json';

class PlaceOrderMap extends StatefulWidget {
  const PlaceOrderMap({Key? key}) : super(key: key);

  @override
  State<PlaceOrderMap> createState() => _PlaceOrderMapState();
}

class _PlaceOrderMapState extends State<PlaceOrderMap> {
  final Completer<GoogleMapController> _controllers = Completer();
  LatLng _selectedDestination = LatLng(0, 0);
  LatLng _selectedLocation = LatLng(0, 0);
  String selectedLocationText = 'Selected Location: Loading...';
  String selectedDestinationText = 'Selected Destination: Loading...';
  bool sourcePoint = false;
  static LatLng _sourceLocation = LatLng(
    35.151649,
    33.904888,
  );
  static LatLng _destination = LatLng(
    35.146837,
    33.908643,
  );
  static CameraPosition _kInitialPosition =
      CameraPosition(target: _sourceLocation, zoom: 15.0, tilt: 0, bearing: 0);

  List<LatLng> polylineCoordinates = [];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      if (kDebugMode) {
        print("ERROR: $error");
      }
    });
    return await Geolocator.getCurrentPosition();
  }

  void getLocation() {
    getUserCurrentLocation().then((position) async {
      if (kDebugMode) {
        print("${position.latitude} ${position.longitude}");
      }

      setState(() {});
    });
  }

  Future<String> getAddressFromCoordinates(LatLng coordinates) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      coordinates.latitude,
      coordinates.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      return placemark.street ?? placemark.name ?? '';
    }

    return '';
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

  void updateSelectedDestinationText() {
    getAddressFromCoordinates(_selectedDestination).then((address) {
      setState(() {
        selectedDestinationText = 'Selected Destination: $address';
      });
      print(selectedDestinationText);
    });
  }

  void updateSelectedLocationText() {
    getAddressFromCoordinates(_selectedLocation).then((address) {
      setState(() {
        selectedLocationText = 'Selected Location: $address';
      });
      print(selectedLocationText);
    });
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
    updateSelectedLocationText();
  }

  late GoogleMapController _controller;

  Future<void> onMapCreated(GoogleMapController controller) async {
    _controllers.complete(controller);
    _controller = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/json/map-dark-mode-style.json');
    _controller.setMapStyle(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'Place Order',
          isActionVisible: true,
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kInitialPosition,
            onMapCreated: onMapCreated,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            myLocationEnabled: true,
            compassEnabled: true,
            mapType: MapType.normal,
            mapToolbarEnabled: true,
            onTap: (LatLng location) {
              setState(() {
                if (sourcePoint) {
                  _selectedLocation = location;
                  _sourceLocation = location;
                  updateSelectedLocationText();
                } else {
                  _selectedDestination = location;
                  _destination = location;
                  updateSelectedDestinationText();
                }
              });
            },
            onLongPress: (LatLng location) {
              setState(() {
                if (sourcePoint) {
                  _selectedLocation = location;
                  _sourceLocation = location;
                  updateSelectedLocationText();
                } else {
                  _selectedDestination = location;
                  _destination = location;
                  updateSelectedDestinationText();
                }
              });
            },
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
                markerId: const MarkerId("source"),
                position: _sourceLocation,
              ),
              Marker(
                markerId: const MarkerId("destination"),
                position: _destination,
              ),
            },
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.1,
            maxChildSize: 0.5,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  sourcePoint = true;
                                });
                              },
                              child: Center(
                                child: Text(
                                  selectedLocationText,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  sourcePoint = false;
                                });
                                // updateSelectedLocationText();
                              },
                              child: Center(
                                child: Text(
                                  selectedDestinationText,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Add destination input field or dropdown.
                          const SizedBox(height: 8),
                          const Text('Product Type'),
                          // Add product type options, such as a dropdown.
                          const SizedBox(height: 8),
                          const Text('Weight'),
                          // Add weight input field or slider.
                          const SizedBox(height: 8),
                          const Text('Date'),
                          TextFormField(
                            onTap: () async {
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year + 1),
                              );
                              if (selectedDate != null) {
                                // Update the date value here
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Select date',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 155,
            child: DraggableScrollableSheet(
              initialChildSize: 1,
              // minChildSize: 0.2,
              maxChildSize: 1,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 181, 11, 11),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  child: ListView(
                    controller: scrollController,
                    children: const [],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
