import 'dart:async';
import 'package:a2b/Components/widgets/custom_button.dart';
import 'package:a2b/main/utils/allConstants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/material.dart';
import '../../../Components/widgets/app_bar_buttons.dart';
import '../../main.dart';
import '../../main/utils/constants.dart';
import 'controller/create_order_controller.dart';

const darkMapStyle = 'assets/json/dark_mode_style.json';
const lightMapStyle = 'assets/json/map-light-mode-style.json';

class PlaceOrderMap extends StatefulWidget {
  const PlaceOrderMap({Key? key}) : super(key: key);

  @override
  State<PlaceOrderMap> createState() => _PlaceOrderMapState();
}

class _PlaceOrderMapState extends State<PlaceOrderMap> {
  final Completer<GoogleMapController> _controllers = Completer();

  List<Location> searchResults = [];

  LatLng _selectedDestination = LatLng(0, 0);
  LatLng _selectedLocation = LatLng(0, 0);

  String selectedLocationText = 'click to select source';
  String selectedDestinationText = 'click to select destination';

  String selectedWeight = 'light';
  String selectedItem = 'Envelope';

  bool sourcePoint = true;
  bool isPickupFocused = false;
  bool isDeliveryFocused = false;

  static LatLng _sourceLocation = const LatLng(
    35.151649,
    33.904888,
  );
  static LatLng _destination = const LatLng(
    35.146837,
    33.908643,
  );

  static CameraPosition _kInitialPosition =
      CameraPosition(target: _sourceLocation, zoom: 15.0, tilt: 0, bearing: 0);

  List<LatLng> polylineCoordinates = [];

  Future<Position> getUserCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permission denied.');
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      print('ERROR: $e');
      rethrow;
    }
  }

  void getLocation() {
    getUserCurrentLocation().then((position) {
      if (kDebugMode) {
        print("${position.latitude} ${position.longitude}");
      }

      setState(() {});
    }).catchError((error) {
      print('ERROR: $error');
    });
  }

  Future<String> getAddressFromCoordinates(LatLng coordinates) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        coordinates.latitude,
        coordinates.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        return placemark.street ?? placemark.name ?? '';
      }

      return '';
    } catch (e) {
      print('ERROR: $e');
      rethrow;
    }
  }

  void updateSelectedDestinationText() {
    getAddressFromCoordinates(_selectedDestination).then((address) {
      setState(() {
        selectedDestinationText = address;
      });
      polylineCoordinates.add(
        LatLng(_selectedDestination.latitude, _selectedDestination.longitude),
      );
      print(polylineCoordinates);
      print(selectedDestinationText);
    }).catchError((error) {
      print('ERROR: $error');
    });
  }

  void updateSelectedLocationText() {
    getAddressFromCoordinates(_selectedLocation).then((address) {
      setState(() {
        selectedLocationText = address;
      });
      polylineCoordinates.add(
        LatLng(_selectedLocation.latitude, _selectedLocation.longitude),
      );
      print(polylineCoordinates);
      print(selectedLocationText);
    }).catchError((error) {
      print('ERROR: $error');
    });
  }

  void getPolyPoints() async {
    try {
      PolylinePoints polylinePoints = PolylinePoints();

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleMapAPIKey,
        PointLatLng(_sourceLocation.latitude, _sourceLocation.longitude),
        PointLatLng(_destination.latitude, _destination.longitude),
        travelMode: TravelMode.driving,
      );

      if (result.points.isNotEmpty) {
        for (var position in result.points) {
          polylineCoordinates.add(
            LatLng(position.latitude, position.longitude),
          );
        }
        setState(() {});
      }
    } catch (e) {
      print('ERROR: $e');
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
    updateSelectedLocationText();
  }

  late GoogleMapController _controller;

  Future<void> onMapCreated(GoogleMapController controller) async {
    String mode = appStore.isDarkMode ? darkMapStyle : lightMapStyle;
    _controllers.complete(controller);
    _controller = controller;
    String value = await DefaultAssetBundle.of(context).loadString(mode);
    _controller.setMapStyle(value);
  }

  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final orderPage1controller = Get.put(PackageController());
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
            // polylines: {
            //   Polyline(
            //     polylineId: const PolylineId("route"),
            //     points: polylineCoordinates,
            //     color: context.primaryColor,
            //     width: 6,
            //   ),
            // },
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
            minChildSize: 0.26,
            maxChildSize: 0.5,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: context.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                ),
                child: ListView(
                  shrinkWrap: true,
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    Center(
                      child: SizedBox(
                        width: 25,
                        child: Container(
                          height: 3,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(39, 42, 40, 1),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
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
                        // ignore: unnecessary_null_comparison
                        text: _selectedDate != null
                            ? DateFormat('dd MMM\nyyyy').format(_selectedDate)
                            : '',
                      ),
                      readOnly: true,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // PICKUP BOX
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              sourcePoint = true;
                              isPickupFocused = true;
                              isDeliveryFocused = false;
                            });
                          },
                          child: Container(
                            width: 175,
                            height: 90,
                            decoration: BoxDecoration(
                              color:
                                  context.secondaryHeaderColor.withOpacity(0.1),
                              border: Border.all(
                                color: isPickupFocused
                                    ? context.primaryColor
                                    : context.secondaryHeaderColor
                                        .withOpacity(0.1),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    language.pickup,
                                    style: TextStyle(
                                      color:
                                          context.primaryColor.withOpacity(0.7),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    selectedLocationText,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // DELIVERY BOX
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              sourcePoint = false;
                              isPickupFocused = false;
                              isDeliveryFocused = true;
                            });
                          },
                          child: Container(
                            width: 175,
                            height: 90,
                            decoration: BoxDecoration(
                              color:
                                  context.secondaryHeaderColor.withOpacity(0.1),
                              border: Border.all(
                                color: isDeliveryFocused
                                    ? context.primaryColor
                                    : context.secondaryHeaderColor
                                        .withOpacity(0.1),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    language.delivery,
                                    style: TextStyle(
                                      color:
                                          context.primaryColor.withOpacity(0.7),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    selectedDestinationText,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {});
                          },
                          child: Container(
                            width: 175,
                            height: 62,
                            decoration: BoxDecoration(
                              color:
                                  context.secondaryHeaderColor.withOpacity(0.1),
                              border: Border.all(
                                color: context.secondaryHeaderColor
                                    .withOpacity(0.1),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    language.parcelType,
                                    style: TextStyle(
                                      color:
                                          context.primaryColor.withOpacity(0.7),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 0,
                                  ),
                                  Container(
                                    // color: Colors.amberAccent,
                                    height: 26,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        icon: SizedBox.shrink(),
                                        value: selectedItem,
                                        items: const [
                                          DropdownMenuItem(
                                            value: 'Envelope',
                                            child: Text('Envelope'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'Rectangular Box',
                                            child: Text('Rectangular Box'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'Cubic Box',
                                            child: Text('Cubic Box'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'Cylinder',
                                            child: Text('Cylinder'),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            try {} catch (e) {
                                              print(e);
                                            }
                                            selectedItem = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // WEIGHT BOX
                        GestureDetector(
                          onTap: () {
                            setState(() {});
                          },
                          child: Container(
                            width: 175,
                            height: 62,
                            decoration: BoxDecoration(
                              color:
                                  context.secondaryHeaderColor.withOpacity(0.1),
                              border: Border.all(
                                color: context.secondaryHeaderColor
                                    .withOpacity(0.1),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    language.weight,
                                    style: TextStyle(
                                      color:
                                          context.primaryColor.withOpacity(0.7),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 0,
                                  ),
                                  SizedBox(
                                    // color: Colors.amberAccent,
                                    height: 26,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        icon: const SizedBox.shrink(),
                                        value: selectedWeight,
                                        items: const [
                                          DropdownMenuItem(
                                            value: 'light',
                                            child: Text('0kg - 5kg'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'normal',
                                            child: Text('5kg - 9kg'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'heavy',
                                            child: Text('9kg+'),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            try {
                                              selectedWeight = value!;
                                            } catch (e) {
                                              print(e);
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
            height: 110,
            child: DraggableScrollableSheet(
              initialChildSize: 1,
              minChildSize: 1,
              maxChildSize: 1,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: context.secondaryHeaderColor,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(0)),
                  ),
                  child: ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomBtn(
                                textonbtn: "Next",
                                onPress: () =>
                                    orderPage1controller.setOrderMapDetails(
                                      context,
                                      selectedItem,
                                      selectedWeight,
                                      selectedLocationText,
                                      selectedDestinationText,
                                      _selectedDate,
                                      _sourceLocation.latitude,
                                      _sourceLocation.longitude,
                                      _sourceLocation.latitude,
                                      _sourceLocation.longitude,
                                    ),
                                primary: true)
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
