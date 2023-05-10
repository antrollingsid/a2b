// ignore_for_file: use_key_in_widget_constructors

import 'package:a2b/Components/widgets/custom_calendar.dart';
import 'package:a2b/User/screens/place_order_upload.dart';
import 'package:a2b/User/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main/utils/allConstants.dart';
import '../../Components/widgets/app_bar_buttons.dart';
import 'dashboard.dart';

class PlaceOrderCalendar extends StatefulWidget {
  const PlaceOrderCalendar({Key? key});

  @override
  State<PlaceOrderCalendar> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrderCalendar> {
  @override
  void initState() {
    super.initState();
  }

  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.backgroundDark,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: CustomAppBar(
            titleText: 'Choose The Date',
            isActionVisible: true,
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CustomCalendar(),
                // CustomShip(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: AppColors.buttonStroke,
            type: BottomNavigationBarType.fixed,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'hhh',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.access_time,
                  color: AppColors.backgroundLightMode,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  height: 62,
                  width: 62,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [
                            AppColors.secondaryBlue,
                            AppColors.primaryDark,
                          ],
                          begin: FractionalOffset(0.0, 1.0),
                          end: FractionalOffset(1.0, 0.4),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Icon(
                    Icons.add,
                    color: AppColors.backgroundDark,
                    size: 40,
                  ),
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.feedback_outlined,
                  color: AppColors.backgroundLightMode,
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outlined,
                  color: AppColors.backgroundLightMode,
                ),
                label: '',
              ),
            ],
            // currentIndex: _selectedIndex,
            selectedItemColor: AppColors.primaryDark,
            onTap: (index) {
              if (index == 0) {
                Get.to(const DashBoard());
              } else if (index == 1) {
                Get.to(const DashBoard());
              } else if (index == 2) {
                Get.to(const PlaceOrderUpload());
              } else if (index == 3) {
              } else if (index == 4) {
                Get.to(const Profile());
              }
            },
          ),
        ));
  }
}
