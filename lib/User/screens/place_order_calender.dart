// ignore_for_file: unused_import, import_of_legacy_library_into_null_safe, duplicate_import, prefer_final_fields, use_key_in_widget_constructors

import 'package:a2b/Components/widgets/custom_button.dart';
import 'package:a2b/Components/widgets/custom_calendar.dart';
import 'package:a2b/User/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../Components/widgets/custom_textfield_fromto.dart';
import '../../main/utils/allConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import '../../Components/widgets/app_bar_buttons.dart';
import '../../Components/widgets/order_activity.dart';
import '../../Components/widgets/shippement.dart';
import 'package:location/location.dart';

class PlaceOrderCalender extends StatefulWidget {
  const PlaceOrderCalender({Key? key});

  @override
  State<PlaceOrderCalender> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrderCalender> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundDark,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'Choose The Date',
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CustomCalendar(),
              CustomShip(),
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
            // Get.to(() => const PlaceOrderCalender());
          }
        },
      ),
    );
  }
}