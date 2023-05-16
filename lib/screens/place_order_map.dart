// ignore_for_file: unused_element, unused_import

import 'package:a2b/Components/widgets/custom_textfield.dart';
import 'package:a2b/controllers/location_text_controller.dart';
import 'package:a2b/screens/dashboard.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
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
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;

  // ignore: prefer_const_constructors
  static final LatLng _kMapCenter = LatLng(
    35.1424,
    33.9116,
  );

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 15.0, tilt: 0, bearing: 0);

  late GoogleMapController _controller;

  Future<void> onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/json/map-dark-mode-style.json');
    _controller.setMapStyle(value);
  }

  @override
  Widget build(BuildContext context) {
    final locationcontroller = Get.put(LocationTextController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
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
                  child: GoogleMap(
                    initialCameraPosition: _kInitialPosition,
                    onMapCreated: onMapCreated,
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                    mapToolbarEnabled: true,
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
