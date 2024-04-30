import 'package:cloud_firestore/cloud_firestore.dart';

import '../../personalization/models/user_model.dart';
import 'room_model.dart';

class BookingModel {
  String roomId;
  DateTime bookingTime;
  DateTime date;
  DateTime startTime;
  DateTime endTime;
  String repeat;
  String userId;
  String status;
  String title;
  String notes;
  RoomModel? roomDetails;
  UserModel? userDetails;
  // UserModel? userDetails;

  BookingModel({
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
    this.roomDetails,
    this.userDetails,
  });

  static BookingModel empty() => BookingModel(
      // bookingId: '',
      roomId: '',
      bookingTime: DateTime.now(),
      date: DateTime.now(),
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      repeat: '',
      userId: '',
      status: '');

  Map<String, dynamic> toJson() {
    return {
      // 'bookingId': bookingId,
      'roomId': roomId,
      'bookingTime': bookingTime,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'repeat': repeat,
      'userId': userId,
      'status': status,
      'title': title,
      'notes': notes,
    };
  }

  factory BookingModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() ?? {};

    return BookingModel(
      // bookingId: document.id,
      roomId: data['roomId'] as String? ?? '',
      bookingTime: (data['bookingTime'] as Timestamp).toDate(),
      date: (data['date'] as Timestamp).toDate(),
      startTime: (data['startTime'] as Timestamp).toDate(), // Corrected
      endTime: (data['endTime'] as Timestamp).toDate(), // Corrected
      repeat: data['repeat'] as String? ?? '',
      userId: data['userId'] as String? ?? '',
      status: data['status'] as String? ?? '',
      title: data['title'] as String? ?? '',
      notes: data['notes'] as String? ?? '',
    );
  }
}
