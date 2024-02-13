// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import '../../../controllers/available_room_controller.dart'; // Import your controller

class TCalendar extends StatefulWidget {
  const TCalendar({super.key});

  @override
  _TCalendarState createState() => _TCalendarState();
}

class _TCalendarState extends State<TCalendar> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  final AvailableRoomController controller =
      Get.find<AvailableRoomController>();

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isBeforeToday(selectedDay) && !isWeekend(selectedDay)) {
          // Schedule a post-frame callback to update the state
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            controller.setSelectedDate(selectedDay); // Update in controller
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      enabledDayPredicate: (day) {
        return !isBeforeToday(day) && !isWeekend(day);
      },
      headerStyle: const HeaderStyle(
        titleCentered: true, // Center the header title
        formatButtonVisible: false, // Hide format button if not needed
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
    );
  }

  bool isBeforeToday(DateTime day) {
    return day.isBefore(DateTime.now().subtract(const Duration(days: 1)));
  }

  bool isWeekend(DateTime day) {
    return day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;
  }
}