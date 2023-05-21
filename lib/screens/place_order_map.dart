// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'package:a2b/main/utils/allConstants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
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
        selectedDestinationText = address;
      });
      print(selectedDestinationText);
    });
  }

  void updateSelectedLocationText() {
    getAddressFromCoordinates(_selectedLocation).then((address) {
      setState(() {
        selectedLocationText = address;
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

  DateTime _selectedDate = DateTime.now();
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
            initialChildSize: 0.5,
            minChildSize: 0.14,
            maxChildSize: 0.5,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(3, 3, 3, 1),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                ),
                child: ListView(
                  shrinkWrap: true,
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    TextFormField(
                      textAlign: TextAlign.start,
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1),
                        );
                        if (selectedDate != null) {
                          // Update the selected date value here
                          setState(() {
                            _selectedDate = selectedDate;
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Select date',
                      ),
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight:
                              FontWeight.w500), // Set font size and bold
                      controller: TextEditingController(
                        text: _selectedDate != null
                            ? DateFormat('dd MMM\nyyyy').format(_selectedDate)
                            : '',
                      ),
                      readOnly: true,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              sourcePoint = true;
                            });
                          },
                          child: Container(
                            width: 160,
                            height: 90,
                            decoration: BoxDecoration(
                              color: AppColors.buttonStroke,
                              border: Border.all(
                                color: AppColors.buttonStroke,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                selectedLocationText,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              sourcePoint = false;
                            });
                          },
                          child: Container(
                            width: 160,
                            height: 90,
                            decoration: BoxDecoration(
                              color: AppColors.buttonStroke,
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                selectedDestinationText,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                      decoration: const InputDecoration(
                        hintText: 'Select date',
                        suffixIcon: Icon(Icons.calendar_today),
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
              initialChildSize: 0.5,
              minChildSize: 0.14,
              maxChildSize: 0.5,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: context.primaryColor,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                  child: ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true, // Added shrinkWrap property
                    padding: const EdgeInsets.all(0), // Adjusted the padding
                    itemCount:
                        1, // Adjust the itemCount to match the number of items
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Add your widgets here
                            Text('data'),
                          ],
                        ),
                      );
                    },
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
