import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/room_model.dart';
import '../models/booking_model.dart';

class AvailableRoomController extends GetxController {
  static AvailableRoomController get instance => Get.find();

  final RxList<RoomModel> availableRoomsId = <RoomModel>[].obs;
  final RxList<BookingModel> bookings = <BookingModel>[].obs;
  final Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
  final Rx<TimeOfDay> selectedStartTime = Rx<TimeOfDay>(TimeOfDay.now());
  final Rx<TimeOfDay> selectedEndTime = Rx<TimeOfDay>(TimeOfDay.now());
  final Rx<RoomModel> selectedRoom = Rx<RoomModel>(RoomModel.empty());

  int _timeOfDayToMinutes(TimeOfDay time) {
    return time.hour * 60 + time.minute;
  }

  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  RoomModel findRoomById(String id) {
    return availableRoomsId.firstWhere((room) => room.id == id,
        orElse: () => RoomModel.empty());
  }

  void updateAvailableRooms(List<RoomModel> allRooms) {
    int selectedStartTimeMinutes = _timeOfDayToMinutes(selectedStartTime.value);
    int selectedEndTimeMinutes = _timeOfDayToMinutes(selectedEndTime.value);

    // Finding bookings that overlap with the selected time range
    var overlappingBookings = bookings.where((booking) {
      int bookingStartTimeMinutes = _timeOfDayToMinutes(booking.startTime);
      int bookingEndTimeMinutes = _timeOfDayToMinutes(booking.endTime);

      // Check if the booking is on the selected date
      bool isSameDay = booking.date.day == selectedDate.value.day &&
          booking.date.month == selectedDate.value.month &&
          booking.date.year == selectedDate.value.year;

      // Check if the booking time overlaps with the selected time
      bool isTimeOverlapping =
          !(selectedStartTimeMinutes >= bookingEndTimeMinutes ||
              selectedEndTimeMinutes <= bookingStartTimeMinutes);

      return isSameDay && isTimeOverlapping;
    }).toList();

    // Filter out rooms that are not booked
    var availableRooms = allRooms.where((room) {
      return !overlappingBookings.any((booking) => booking.roomId == room.id);
    }).toList();

    availableRoomsId.value = availableRooms;
  }
}
