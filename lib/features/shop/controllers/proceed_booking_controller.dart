import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './dummy_data.dart';
import '../models/booking_model.dart';

class ProceedBookingController extends GetxController {
  void createBooking(String roomId, DateTime selectedDate, TimeOfDay selectedStartTime, TimeOfDay selectedEndTime) {
    String bookingId = "B${(TDummyData.bookings.length + 1).toString().padLeft(3, '0')}";

    // You may replace these with actual values as needed
    String repeatValue = 'none'; // Example: 'daily', 'weekly', etc.
    String userIdValue = 'DefaultUser'; // Replace with the actual user ID
    String statusValue = 'upcoming'; // Example: 'active', 'completed', etc.

    BookingModel newBooking = BookingModel(
      bookingId: bookingId,
      roomId: roomId,
      bookingTime: DateTime.now(),
      date: selectedDate,
      startTime: selectedStartTime,
      endTime: selectedEndTime,
      repeat: repeatValue,
      userId: userIdValue,
      status: statusValue,
      // ... other properties
    );

    TDummyData.bookings.add(newBooking);
    // Trigger any updates or navigation if necessary
  }
}
