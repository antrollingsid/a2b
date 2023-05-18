// ignore_for_file: unused_element, unused_import

import 'dart:async';

import 'package:a2b/Components/widgets/custom_textfield.dart';
import 'package:a2b/controllers/location_text_controller.dart';
import 'package:a2b/screens/dashboard.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../Components/widgets/custom_textfield_fromto.dart';
import '../../main/utils/allConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import '../../Components/widgets/app_bar_buttons.dart';
import '../../Components/widgets/order_activity.dart';
import '../../Components/widgets/shippement.dart';
import 'package:location/location.dart';
//yandix api maps check ?????
import '../Components/widgets/custom_button.dart';
import 'place_order_calendar.dart';

const darkMapStyle = 'assets/json/dark_mode_style.json';

class PlaceOrderMap extends StatefulWidget {
  const PlaceOrderMap({super.key});

  @override
  State<PlaceOrderMap> createState() => _PlaceOrderMapState();
}

class _PlaceOrderMapState extends State<PlaceOrderMap> {
  final Completer<GoogleMapController> _controller = Completer();
  // void _onItemTapped(int index) {
  //   setState(() {
  //     // _selectedIndex = index;
  //   });
  // }

  // int _selectedIndex = 0;

  // ignore: prefer_const_constructors
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

  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
  }

  void getPolyPoints() async {
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
  }

  @override
  void initState() {
    // getCurrentLocation();
    getPolyPoints();
    super.initState();
  }
  // late GoogleMapController _controller;

//   Future<void> onMapCreated(GoogleMapController controller) async {
//     _controller = controller;
//     String value = await DefaultAssetBundle.of(context)
//         .loadString('assets/json/map-dark-mode-style.json');
//     _controller.setMapStyle(value);

//   }
// _controller.setMapStyle(DefaultAssetBundle.of(context)
//         .loadString('assets/json/map-dark-mode-style.json'));
  @override
  Widget build(BuildContext context) {
    final locationcontroller = Get.put(LocationTextController());

    return Scaffold(
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundLightMode,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'Place Order',
          isActionVisible: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                width: 333,
                height: 374,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: currentLocation == null
                      ? Text(
                          "loadin",
                          style: TextStyle(color: Colors.black),
                        )
                      : GoogleMap(
                          initialCameraPosition: _kInitialPosition,
                          // onMapCreated: onMapCreated,
                          zoomControlsEnabled: true,
                          zoomGesturesEnabled: true,
                          mapToolbarEnabled: true,
                          polylines: {
                            Polyline(
                              polylineId: PolylineId("route"),
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
              CustomTextfield(
                  isPassword: false,
                  hintText: 'Where from?',
                  mycontroller: locationcontroller.from,
                  width: 333),
              CustomTextfield(
                  isPassword: false,
                  hintText: 'Where to?',
                  mycontroller: locationcontroller.to,
                  width: 333),
              CustomTextfield(
                  isPassword: false,
                  hintText: 'receiver\'s name',
                  mycontroller: locationcontroller.name,
                  width: 333),
              SizedBox(
                width: 333,
                child: IntlPhoneField(
                  showCountryFlag: false,
                  controller: locationcontroller.number,
                  decoration: InputDecoration(
                    prefixIcon: null,
                    border: myinputborder(),
                    enabledBorder: myinputborder(), //enabled border
                    focusedBorder: myfocusborder(),
                  ),
                  initialCountryCode: 'TR',
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                ),
              ),
              CustomBtn(
                textonbtn: 'Next',
                onPress: () => Get.to(() => const ConfirmOrder()),
                primary: true,
              ),
            ],
          ),
        ),
      ),
    );
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
