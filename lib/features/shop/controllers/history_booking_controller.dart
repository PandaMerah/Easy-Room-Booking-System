import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../personalization/models/user_model.dart';
import '../models/booking_model.dart';
import '../models/room_model.dart';
import '../../personalization/controllers/user_controller.dart';

class HistoryBookingController extends GetxController {
  final bookings = <BookingModel>[].obs;
  final UserController userController = Get.find<UserController>();
  final activeBookings = <BookingModel>[].obs;
  final upcomingBookings = <BookingModel>[].obs;
  final endedBookings = <BookingModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllBookingsWithRoomDetails();
  }

  Future<void> fetchAllBookingsWithRoomDetails() async {
    final userId = userController.user.value.id;
    if (userId.isEmpty) {
      // Handle case where there is no user logged in
      return;
    }

    final bookingSnapshotFuture =
        FirebaseFirestore.instance.collection('Bookings').get();
    final roomsSnapshotFuture =
        FirebaseFirestore.instance.collection('Rooms').get();
    final usersSnapshotFuture =
        FirebaseFirestore.instance.collection('Users').get();

    final results = await Future.wait(
        [bookingSnapshotFuture, roomsSnapshotFuture, usersSnapshotFuture]);

    final bookingSnapshot = results[0];
    final roomSnapshot = results[1];
    final userSnapshot = results[2];

    List<BookingModel> fetchedBookings = bookingSnapshot.docs
        .map((doc) => BookingModel.fromSnapshot(doc))
        .toList();
    Map<String, RoomModel> roomMap = {
      for (var doc in roomSnapshot.docs) doc.id: RoomModel.fromSnapshot(doc)
    };
    Map<String, UserModel> userMap = {
      for (var doc in userSnapshot.docs) doc.id: UserModel.fromSnapshot(doc)
    };

    for (var booking in fetchedBookings) {
      booking.roomDetails = roomMap[booking.roomId];
      booking.userDetails = userMap[booking.userId];
    }

    // Group bookings by roomId
    Map<String, List<BookingModel>> groupedBookings = {};
    for (var booking in fetchedBookings) {
      (groupedBookings[booking.roomId] ??= []).add(booking);
    }

    // Sort each group by date, then by endTime
    for (var bookings in groupedBookings.values) {
      bookings.sort((a, b) {
        int compareDate = a.date.compareTo(b.date);
        if (compareDate != 0) return compareDate;
        return a.endTime.compareTo(b.endTime);
      });
    }

    // Flatten the groups back into a single list, maintaining room order if needed
    List<String> sortedRoomIds = groupedBookings.keys
        .toList(); // Sort this list if room order is important
    // Example room ID sort (assuming numeric IDs): sortedRoomIds.sort((a, b) => int.parse(a).compareTo(int.parse(b)));

    List<BookingModel> sortedAndGroupedBookings =
        sortedRoomIds.expand((roomId) => groupedBookings[roomId]!).toList();

    bookings.assignAll(sortedAndGroupedBookings);
    categorizeBookings();
  }

  void categorizeBookings() {
    DateTime now = DateTime.now();

    // The following lists inherit the sort order from `bookings`
    activeBookings.assignAll(
      bookings
          .where((booking) =>
              booking.startTime.isBefore(now) && booking.endTime.isAfter(now))
          .toList(),
    );
    upcomingBookings.assignAll(
      bookings.where((booking) => booking.startTime.isAfter(now)).toList(),
    );
    endedBookings.assignAll(
      bookings.where((booking) => booking.endTime.isBefore(now)).toList(),
    );
  }
}
