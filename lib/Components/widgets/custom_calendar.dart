import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../main/utils/colors.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  final DateTime _firstDay = DateTime.utc(2022, 10, 16);
  final DateTime _lastDay = DateTime.utc(2030, 10, 16);
  DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 333,
      height: 374,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 40, 40, 40),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TableCalendar(
        firstDay: _firstDay,
        focusedDay: _focusedDay,
        lastDay: _lastDay,

        /*----------------
         ---- HEAADER ----
         ----------------*/
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            color: AppColors.backgroundLightMode,
          ),
        ),
        calendarStyle: CalendarStyle(
          cellAlignment: Alignment.center,

          /*-----------------
           ---- SELECTED ----
           -----------------*/
          selectedDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryDark,
          ),
          selectedTextStyle: const TextStyle(
            color: AppColors.backgroundDark,
          ),

          /*-----------------
           ----  DEFAULT ----
           -----------------*/
          defaultTextStyle: const TextStyle(
            color: AppColors.textGrey,
          ),
          defaultDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            // backgroundBlendMode: BlendMode.clear,
            borderRadius: BorderRadius.circular(10),
          ),

          /*--------------
           ---- TODAY ----
           --------------*/
          isTodayHighlighted: true,
          todayDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(10),
          ),
          todayTextStyle: const TextStyle(
            color: AppColors.backgroundDark,
          ),

          /*----------------
           ---- OUTSIDE ----
           ----------------*/
          outsideDaysVisible: true,
          outsideDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
          ),
          outsideTextStyle: const TextStyle(
            color: Color.fromARGB(255, 88, 88, 88),
          ),

          /*----------------
           ---- WEEKEND ----
           ----------------*/
          weekendTextStyle: const TextStyle(
            color: AppColors.textGrey,
          ),
          weekendDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
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
              _focusedDay = focusedDay; // update `_focusedDay` here as well
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
    );
  }
}
