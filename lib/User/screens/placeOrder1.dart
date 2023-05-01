import 'package:a2b/User/screens/dashboard.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../Components/widgets/custom_textfield_fromto.dart';
import '../../main/utils/allConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import '../../Components/widgets/appBar_buttons.dart';
import '../../Components/widgets/order_activity.dart';
import '../../Components/widgets/shippement.dart';
import 'package:location/location.dart';

const darkMapStyle = 'assets/json/dark_mode_style.json';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({super.key});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundDark,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'Place Order',
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
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
                  ),
                ),
              ),
              const FromToTextField(
                hintText: 'enter location',
                titleText: 'FROM',
                type: 'from',
              ),
              const FromToTextField(
                hintText: 'enter location',
                titleText: 'TO',
                type: 'to',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: AppColors.buttonStroke,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.access_time,
              color: AppColors.backgroundLightMode,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              color: AppColors.backgroundLightMode,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.feedback_outlined,
              color: AppColors.backgroundLightMode,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outlined,
              color: AppColors.backgroundLightMode,
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primaryDark,
        onTap: (index) {
          if (index == 2) {
            Get.to(() => const PlaceOrder());
          }
        },
      ),
    );
  }
}
