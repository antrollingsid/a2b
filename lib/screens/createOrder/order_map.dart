import 'dart:async';
import 'package:a2b/Components/widgets/custom_button.dart';
import 'package:a2b/main/utils/allConstants.dart';
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
import 'controller/create_order_controller.dart';

const darkMapStyle = 'assets/json/map-dark-mode-style.json';
const lightMapStyle = 'assets/json/map-light-mode-style.json';

class PlaceOrderMap extends StatefulWidget {
  const PlaceOrderMap({Key? key}) : super(key: key);

  @override
  State<PlaceOrderMap> createState() => _PlaceOrderMapState();
}

class _PlaceOrderMapState extends State<PlaceOrderMap> {
  final Completer<GoogleMapController> _controllers = Completer();
  Map<PolylineId, Polyline> polylines = {};
  LatLng _selectedDestination =
      const LatLng(35.15571933375463, 33.900646269321435);
  LatLng _selectedLocation = const LatLng(35.15115787475357, 33.90726964920759);

  String selectedLocationText = 'click to select source';
  String selectedDestinationText = 'click to select destination';

  String selectedWeight = 'light';
  String selectedItem = 'Envelope';
  PolylinePoints polylinePoints = PolylinePoints();

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
  Set<Polyline> polylineSet = {};
  static final CameraPosition _kInitialPosition =
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
      print(polylineSet);
    }).catchError((error) {
      print('ERROR: $error');
    });
  }

  void getPolyPoints() async {
    polylinePoints = PolylinePoints();
    polylineCoordinates.clear(); // Clear the previous polyline coordinates
    polylines.clear();
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleMapAPIKey,
        PointLatLng(_selectedLocation.latitude, _selectedLocation.longitude),
        PointLatLng(
            _selectedDestination.latitude, _selectedDestination.longitude),
        travelMode: TravelMode.driving,
      );
      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      }
      PolylineId id = const PolylineId('poly');
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates,
        width: 3,
      );
      setState(() {
        polylines[id] = polyline; // Update the polylines map
      });
    } catch (e) {
      print('ERROR: $e');
    }
  }

  late GoogleMapController _controller;

  Future<void> onMapCreated(GoogleMapController controller) async {
    String mode = appStore.isDarkMode ? darkMapStyle : lightMapStyle;
    _controllers.complete(controller);
    _controller = controller;
    String value = await DefaultAssetBundle.of(context).loadString(mode);
    _controller.setMapStyle(value);

    setState(() {});
    getPolyPoints();
  }

  DateTime _selectedDate = DateTime.now();
  @override
  void initState() {
    // try {
    //   getLocation();
    // } catch (e) {
    //   print(e);
    // }
    getPolyPoints();

    super.initState();
    updateSelectedLocationText();
  }

  @override
  Widget build(BuildContext context) {
    final orderPage1controller = Get.put(PackageController());
    return Scaffold(
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'Place Order',
          isActionVisible: true,
          isLeadingVisible: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 333,
            child: Column(
              children: [
                SizedBox(
                  width: 333,
                  height: 374,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: GoogleMap(
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
                      markers: {
                        Marker(
                          markerId: const MarkerId('source'),
                          position: _sourceLocation,
                        ),
                        Marker(
                          markerId: const MarkerId('destination'),
                          position: _destination,
                        ),
                      },
                      // polylines: Set<Polyline>.of(polylines.values),
                    ),
                  ),
                ),
                TextFormField(
                  textAlign: TextAlign.left,
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 1),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _selectedDate = selectedDate;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Select date',
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: context.primaryColor,
                    ),
                  ),
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w500),
                  controller: TextEditingController(
                    // ignore: unnecessary_null_comparison
                    text: _selectedDate != null
                        ? DateFormat('dd MMM yyyy').format(_selectedDate)
                        : '',
                  ),
                  readOnly: true,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
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
                        width: 333,
                        height: 53,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight.withOpacity(0.1),
                          border: Border.all(
                            color: isPickupFocused
                                ? (appStore.isDarkMode
                                    ? AppColors.primaryDark
                                    : AppColors.primaryLight)
                                : AppColors.backgroundLight.withOpacity(0.1),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Row(
                          children: [
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 125,
                                  height: 53,
                                  decoration: BoxDecoration(
                                    color: appStore.isDarkMode
                                        ? AppColors.primaryDark
                                        : AppColors.primaryLight,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      language.from,
                                      style: TextStyle(
                                        color: appStore.isDarkMode
                                            ? AppColors.backgroundDark
                                            : AppColors.backgroundLight,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  color: null,
                                  width: 206,
                                  child: Center(
                                    child: Text(
                                      selectedLocationText,
                                      style: TextStyle(
                                        color: appStore.isDarkMode
                                            ? AppColors.onBackgroundDark
                                            : AppColors.onBackgroundLight,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                        width: 333,
                        height: 53,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight.withOpacity(0.1),
                          border: Border.all(
                            color: isDeliveryFocused
                                ? (appStore.isDarkMode
                                    ? AppColors.secondaryDark
                                    : AppColors.secondaryLight)
                                : AppColors.backgroundLight.withOpacity(0.1),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 125,
                                  height: 53,
                                  decoration: BoxDecoration(
                                    color: appStore.isDarkMode
                                        ? AppColors.secondaryDark
                                        : AppColors.secondaryLight,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      language.to,
                                      style: TextStyle(
                                        color: appStore.isDarkMode
                                            ? AppColors.backgroundDark
                                            : AppColors.backgroundLight,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              color: null,
                              width: 206,
                              child: Center(
                                child: Text(
                                  selectedDestinationText,
                                  style: TextStyle(
                                    color: appStore.isDarkMode
                                        ? AppColors.onBackgroundDark
                                        : AppColors.onBackgroundLight,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                        width: 160,
                        height: 62,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight.withOpacity(0.1),
                          border: Border.all(
                            color: AppColors.backgroundLight.withOpacity(0.1),
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
                                  color: appStore.isDarkMode
                                      ? AppColors.primaryDark
                                      : AppColors.primaryLight,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 23,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    icon: const SizedBox.shrink(),
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
                        width: 160,
                        height: 62,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight.withOpacity(0.1),
                          border: Border.all(
                            color: AppColors.backgroundLight.withOpacity(0.1),
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
                                  color: appStore.isDarkMode
                                      ? AppColors.primaryDark
                                      : AppColors.primaryLight,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                // color: Colors.amberAccent,
                                height: 23,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomBtn(
                        textonbtn: "Next",
                        onPress: () => orderPage1controller.setOrderMapDetails(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
