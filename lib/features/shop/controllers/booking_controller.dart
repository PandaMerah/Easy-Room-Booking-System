import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/booking_model.dart';
import '../models/room_model.dart';
import '../../personalization/controllers/user_controller.dart';

class BookingController extends GetxController {
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
    // Ensure you have a valid user ID
    final userId = userController.user.value.id;
    if (userId.isEmpty) {
      // Handle case where there is no user logged in
      return;
    }

    // Fetch bookings for the logged-in user and rooms concurrently to improve performance
    final bookingSnapshotFuture = FirebaseFirestore.instance
        .collection('Bookings')
        .where('userId', isEqualTo: userId) // Filter bookings by userId
        .get();
    final roomsSnapshotFuture =
        FirebaseFirestore.instance.collection('Rooms').get();

    // Await both futures to complete
    final bookingSnapshot = await bookingSnapshotFuture;
    final roomSnapshot = await roomsSnapshotFuture;

    List<BookingModel> fetchedBookings = bookingSnapshot.docs
        .map((doc) => BookingModel.fromSnapshot(doc))
        .toList();
    List<RoomModel> allRooms =
        roomSnapshot.docs.map((doc) => RoomModel.fromSnapshot(doc)).toList();

    // Create a map of roomId to RoomModel for quick room details lookup
    Map<String, RoomModel> roomMap = {for (var room in allRooms) room.id: room};

    // Attach room details to each booking
    for (var booking in fetchedBookings) {
      if (roomMap.containsKey(booking.roomId)) {
        booking.roomDetails = roomMap[booking.roomId];
      }
    }

    // Update observable list of bookings and categorize them
    bookings.assignAll(fetchedBookings);
    categorizeBookings();
  }

  void categorizeBookings() {
    DateTime now = DateTime.now();
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
