import 'package:get/get.dart';
import '../models/booking_model.dart';
import 'dummy_data.dart';

class BookingController extends GetxController {
  static BookingController get instance => Get.find();

  final bookings = <BookingModel>[].obs;

  /// -- Initialize Bookings from your backend
  @override
  void onInit() {
    // You can initialize bookings from your backend here, but for this example, we're using dummy data.
    bookings.value = TDummyData.bookings;
    super.onInit();
  }

  /// -- Get All Bookings
  List<BookingModel> getAllBookings() {
    final bookings = TDummyData.bookings.toList();
    return bookings;
  }

  /// -- Get Bookings by Status
  List<BookingModel> getBookingsByStatus(String status) {
    final bookings = TDummyData.bookings
        .where((booking) => booking.status == status)
        .toList();
    return bookings;
  }

  /// -- Get Bookings by Room
  List<BookingModel> getBookingsByRoom(String roomId) {
    final bookings = TDummyData.bookings
        .where((booking) => booking.roomId == roomId)
        .toList();
    return bookings;
  }

  /// -- Get Bookings by User
  List<BookingModel> getBookingsByUser(String userId) {
    final bookings = TDummyData.bookings
        .where((booking) => booking.userId == userId)
        .toList();
    return bookings;
  }

  /// -- Get Bookings by Date
  List<BookingModel> getBookingsByDate(DateTime date) {
    final bookings =
        TDummyData.bookings.where((booking) => booking.date == date).toList();
    return bookings;
  }

  /// -- Get Bookings by Date Range
  List<BookingModel> getBookingsByDateRange(
      DateTime startDate, DateTime endDate) {
    final bookings = TDummyData.bookings
        .where((booking) =>
            booking.date.isAfter(startDate) && booking.date.isBefore(endDate))
        .toList();
    return bookings;
  }

  /// -- Get Bookings by Room and Date
  List<BookingModel> getBookingsByRoomAndDate(String roomId, DateTime date) {
    final bookings = TDummyData.bookings
        .where((booking) => booking.roomId == roomId && booking.date == date)
        .toList();
    return bookings;
  }
}
