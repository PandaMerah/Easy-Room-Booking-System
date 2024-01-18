import 'package:flutter/material.dart';

class BookingModel {
  String bookingId;
  String roomId;
  DateTime bookingTime;
  DateTime date;
  TimeOfDay startTime;
  TimeOfDay endTime;
  String repeat;
  String userId;
  String status;
  String title;
  String notes;

  BookingModel({
    required this.bookingId,
    required this.roomId,
    required this.bookingTime,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.repeat,
    required this.userId,
    required this.status,
    this.title = '',
    this.notes = '',
  });

  static BookingModel empty() => BookingModel(
      bookingId: '',
      roomId: '',
      bookingTime: DateTime.now(),
      date: DateTime.now(),
      startTime: TimeOfDay.now(),
      endTime: TimeOfDay.now(),
      repeat: '',
      userId: '',
      status: '');

  // Create a method to map from JSON or your data source format, if necessary
  // static BookingModel fromMap(Map<String, dynamic> map) {
  //   return BookingModel(
  //     // Assign values from 'map' to the respective fields
  //   );
  // }

  // Similarly, you can create a method to convert the booking data to a Map or JSON format
  // Map<String, dynamic> toMap() {
  //   return {
  //     // Convert fields to key-value pairs
  //   };
  // }
}
