import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../models/booking_model.dart';

class BookingController extends GetxController {
  static BookingController get instance => Get.find();

  final bookings = <BookingModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllBookings();
  }

  Future<void> fetchAllBookings() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('Bookings').get();
      var fetchedBookings =
          snapshot.docs.map((doc) => BookingModel.fromSnapshot(doc)).toList();
      bookings.assignAll(fetchedBookings);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching bookings: $e');
      }
      // Handle the error appropriately
    }
  }

  List<BookingModel> getAllBookings() {
    return bookings.toList();
  }

  // Update methods to use the bookings list from Firestore
  List<BookingModel> getBookingsByStatus(String status) {
    return bookings.where((booking) => booking.status == status).toList();
  }

  List<BookingModel> getBookingsByRoom(String roomId) {
    return bookings.where((booking) => booking.roomId == roomId).toList();
  }

  List<BookingModel> getBookingsByUser(String userId) {
    return bookings.where((booking) => booking.userId == userId).toList();
  }

  List<BookingModel> getBookingsByDate(DateTime date) {
    return bookings
        .where((booking) => booking.date.isAtSameMomentAs(date))
        .toList();
  }

  List<BookingModel> getBookingsByDateRange(
      DateTime startDate, DateTime endDate) {
    return bookings
        .where((booking) =>
            booking.date.isAfter(startDate) && booking.date.isBefore(endDate))
        .toList();
  }

  List<BookingModel> getBookingsByRoomAndDate(String roomId, DateTime date) {
    return bookings
        .where((booking) =>
            booking.roomId == roomId && booking.date.isAtSameMomentAs(date))
        .toList();
  }
}
