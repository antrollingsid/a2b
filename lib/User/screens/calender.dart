// ignore_for_file: unused_import, import_of_legacy_library_into_null_safe, duplicate_import, prefer_final_fields, use_key_in_widget_constructors

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
  late CalendarController _controller;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
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
                  firstDay: DateTime.utc(2010, 10, 16),
                  focusedDay: DateTime.now(),
                  lastDay: DateTime.utc(2030, 3, 14),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primaryDark,
                    ),
                    isTodayHighlighted: true,
                    cellAlignment: Alignment.center,
                    todayDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    outsideDecoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      // borderRadius: BorderRadius.circular(10),
                    ),
                    defaultDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      // backgroundBlendMode: BlendMode.clear,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    outsideDaysVisible: true,
                    outsideTextStyle: const TextStyle(
                      color: AppColors.textGrey,
                    ),
                    weekendTextStyle: const TextStyle(
                      color: AppColors.textGrey,
                    ),
                    weekendDecoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  headerVisible: true,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(
                      () {
                        _selectedDay = selectedDay;
                        _focusedDay =
                            focusedDay; // update `_focusedDay` here as well
                      },
                    );
                  },
                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
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
