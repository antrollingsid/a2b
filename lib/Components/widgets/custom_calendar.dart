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
        rowHeight: 48,
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            color: AppColors.textGrey,
          ),
          weekendStyle: TextStyle(
            color: AppColors.textGrey,
          ),
        ),

        /*----------------
         ---- HEAADER ----
         ----------------*/
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: AppColors.secondaryDark,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: AppColors.secondaryDark,
          ),
          titleTextStyle: TextStyle(
            color: AppColors.backgroundLight,
          ),
        ),
        calendarStyle: CalendarStyle(
          tablePadding: const EdgeInsets.only(top: 6),
          cellAlignment: Alignment.center,

          /*-----------------
           ---- SELECTED ----
           -----------------*/
          selectedDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryLight,
          ),
          selectedTextStyle: const TextStyle(
            color: AppColors.backgroundLight,
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
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: AppColors.primaryLight,
            ),
          ),
          todayTextStyle: const TextStyle(
            color: AppColors.primaryLight,
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
            color: Color.fromARGB(255, 68, 68, 68),
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
          return isSameDay(day, _selectedDay);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(
            () {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
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
