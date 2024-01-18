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









// class TCalendar extends StatefulWidget {
//   const TCalendar({super.key});

//   @override
//   _TCalendarState createState() => _TCalendarState();
// }

// class _TCalendarState extends State<TCalendar> {
//   late BookingService mockBookingService;
//   final DateTime now = DateTime.now();
//   final List<DateTimeRange> converted = [];

//   @override
//   void initState() {
//     super.initState();
//     final now = DateTime.now();

//     mockBookingService = BookingService(
//         serviceName: 'Mock Service',
//         serviceDuration: 60,
//         bookingEnd: DateTime(now.year, now.month, (now.day + 30), 17, 0),
//         bookingStart: DateTime(now.year, now.month, now.day, 8, 0));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BookingCalendar(
//       bookingService: mockBookingService,
//       getBookingStream: getBookingStreamMock,
//       uploadBooking: uploadBookingMock,
//       convertStreamResultToDateTimeRanges: convertStreamResultMock,
//     );
//   }

//   Stream<dynamic>? getBookingStreamMock(
//       {required DateTime end, required DateTime start}) {
//     return Stream.value([]);
//   }

//   Future<dynamic> uploadBookingMock(
//       {required BookingService newBooking}) async {
//     await Future.delayed(const Duration(seconds: 1));
//     converted.add(DateTimeRange(
//         start: newBooking.bookingStart, end: newBooking.bookingEnd));
//     print('${newBooking.toJson()} has been uploaded');
//   }

//   List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
//     // Mock conversion logic
//     DateTime first = now;
//     DateTime tomorrow = now.add(const Duration(days: 1));
//     DateTime second = now.add(const Duration(minutes: 55));
//     DateTime third = now.subtract(const Duration(minutes: 240));
//     DateTime fourth = now.subtract(const Duration(minutes: 500));
//     converted.add(
//         DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
//     converted.add(DateTimeRange(
//         start: second, end: second.add(const Duration(minutes: 23))));
//     converted.add(DateTimeRange(
//         start: third, end: third.add(const Duration(minutes: 15))));
//     converted.add(DateTimeRange(
//         start: fourth, end: fourth.add(const Duration(minutes: 50))));

//     //book whole day example
//     converted.add(DateTimeRange(
//         start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 5, 0),
//         end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 0)));
//     return converted;
//   }
// }
