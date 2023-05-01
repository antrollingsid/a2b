// ignore_for_file: unused_import, import_of_legacy_library_into_null_safe, duplicate_import, prefer_final_fields, use_key_in_widget_constructors

import 'package:a2b/User/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  late CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
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
            children: [
              Container(
                width: 333,
                height: 374,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 40, 40, 40),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TableCalendar(
                  calendarController: _controller, // use the controller here
                  initialCalendarFormat: CalendarFormat.month,
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekendStyle: TextStyle(
                      color: AppColors.textGrey,
                    ),
                    weekdayStyle: TextStyle(
                      color: AppColors.textGrey,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    weekdayStyle: const TextStyle(
                      color: AppColors.textGrey,
                    ),
                    weekendStyle: const TextStyle(
                      color: AppColors.textGrey,
                    ),
                    outsideWeekendStyle: const TextStyle(
                      color: Color.fromARGB(255, 80, 80, 80),
                    ),
                    outsideStyle: const TextStyle(
                      color: Color.fromARGB(255, 80, 80, 80),
                    ),
                    todayColor: AppColors.secondaryBlue,
                    selectedColor: Theme.of(context).primaryColor,
                    todayStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: AppColors.backgroundLightMode,
                    ),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: AppColors.backgroundLightMode,
                    ),
                    titleTextStyle: TextStyle(
                      color: AppColors.backgroundLightMode,
                    ),
                    centerHeaderTitle: true,
                    formatButtonVisible: false,
                    formatButtonTextStyle: TextStyle(color: Colors.white),
                    formatButtonShowsNext: false,
                  ),
                  startingDayOfWeek: StartingDayOfWeek.monday,

                  // onDaySelected: (date, events) {
                  //   print(date.toUtc());
                  // },
                  builders: CalendarBuilders(
                    selectedDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(5.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        date.day.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    todayDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(5.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        date.day.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
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
            // Get.to(() => const PlaceOrderCalender());
          }
        },
      ),
    );
  }
}
