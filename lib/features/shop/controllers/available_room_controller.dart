import 'package:get/get.dart';
import '../models/room_model.dart';
import '../models/booking_model.dart';
import './booking_controller.dart';
import 'room_controller.dart'; // Import BookingController

class AvailableRoomController extends GetxController {
  static AvailableRoomController get instance => Get.find();
  final BookingController bookingController =
      Get.find(); // Access BookingController
  final RoomController roomController = Get.find();

  final RxList<RoomModel> availableRooms = <RoomModel>[].obs;
  final Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
  final Rx<DateTime> selectedStartTime = Rx<DateTime>(DateTime.now());
  final Rx<DateTime> selectedEndTime = Rx<DateTime>(DateTime.now());
  final Rx<RoomModel> selectedRoom = Rx<RoomModel>(RoomModel.empty());
  RxString bookingTitle = ''.obs;
  RxString bookingNotes = ''.obs;

  int _timeOfDayToMinutes(DateTime time) {
    return time.hour * 60 + time.minute;
  }

  DateTime roundToNearestHalfHour(DateTime time) {
    int newMinute = (time.minute >= 30) ? 30 : 0;
    DateTime roundedTime =
        DateTime(time.year, time.month, time.day, time.hour, newMinute);

    // If the original time is past the 30-minute mark and we set newMinute to 0,
    // we should add an hour to the time. Also, adjust if the original time is close to next hour.
    if (time.minute > 30 || (newMinute == 0 && time.minute > 0)) {
      roundedTime = roundedTime.add(const Duration(hours: 1));
    }

    // Additionally, if the roundedTime is still in the past, adjust it forward by 30 minutes.
    if (roundedTime.isBefore(DateTime.now())) {
      roundedTime = roundedTime.add(const Duration(minutes: 30));
    }

    return roundedTime;
  }

  void adjustTimeToNearestHalfHour() {
    final DateTime now = DateTime.now();
    DateTime newStartTime = selectedStartTime.value;
    DateTime newEndTime = selectedEndTime.value;

    // Round the current or selected start time to the next or current half-hour mark
    newStartTime =
        roundToNearestHalfHour(newStartTime.isBefore(now) ? now : newStartTime);
    // Ensure the end time is at least 30 minutes after the new start time
    newEndTime = newStartTime.add(const Duration(minutes: 30));

    selectedStartTime.value = newStartTime;
    selectedEndTime.value = newEndTime;
  }

  Future<void> updateAvailableRooms() async {
    List<RoomModel> allRooms = roomController.allRooms;
    List<BookingModel> bookings = bookingController.bookings;

    int selectedStartTimeMinutes = _timeOfDayToMinutes(selectedStartTime.value);
    int selectedEndTimeMinutes = _timeOfDayToMinutes(selectedEndTime.value);

    var overlappingBookings = bookings.where((booking) {
      int bookingStartTimeMinutes = _timeOfDayToMinutes(booking.startTime);
      int bookingEndTimeMinutes = _timeOfDayToMinutes(booking.endTime);

      bool isSameDay = booking.date.day == selectedDate.value.day &&
          booking.date.month == selectedDate.value.month &&
          booking.date.year == selectedDate.value.year;

      // Adjusted logic for time overlap
      bool isTimeOverlapping =
          selectedStartTimeMinutes < bookingEndTimeMinutes &&
              selectedEndTimeMinutes > bookingStartTimeMinutes;

      return isSameDay && isTimeOverlapping;
    }).toList();
    Set<String> bookedRoomIds =
        overlappingBookings.map((b) => b.roomId).toSet();
    availableRooms.value =
        allRooms.where((room) => !bookedRoomIds.contains(room.id)).toList();
  }

  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
    updateAvailableRooms();
  }

  // RoomModel findRoomById(String id) {
  //   return availableRooms.firstWhere((room) => room.id == id,
  //       orElse: () => RoomModel.empty());
  // }
}
