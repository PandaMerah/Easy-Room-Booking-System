import 'package:cwt_ecommerce_ui_kit/features/shop/screens/select_datetime/select_datetime.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../features/shop/controllers/available_room_controller.dart';
import '../../../../features/shop/controllers/dummy_data.dart';
import '../../../../features/shop/models/booking_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../divider/t_divider.dart';
import '../../layouts/grid_layout.dart';
import '../room_card/room_card_vertical.dart';

class TAvailableRooms extends StatelessWidget {
  const TAvailableRooms({
    super.key,
    required this.bookings,
    // required this.rooms,
  });

  final List<BookingModel> bookings; // List of all bookings
  // final List<RoomModel> rooms; // List of all rooms

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AvailableRoomController());

    // Fetch all rooms and update available rooms
    // Replace this with your actual method to fetch or define the list of all rooms
    controller.updateAvailableRooms(TDummyData.rooms);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Selection Bar
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() {
              final now = DateTime.now();
              final selectedDate = controller.selectedDate.value;
              final selectedStartTime = controller.selectedStartTime.value;
              final selectedEndTime = controller.selectedEndTime.value;

              String dateText = DateFormat('EEE MM/dd').format(selectedDate);
              if (selectedDate.year == now.year &&
                  selectedDate.month == now.month &&
                  selectedDate.day == now.day) {
                dateText = 'Today';
              }

              final buttonText =
                  '$dateText, ${selectedStartTime.format(context)} - ${selectedEndTime.format(context)}';

              // Button for selecting the booking date and time
              return ElevatedButton(
                onPressed: () => Get.to(() => SelectDateTime()),
                child: Text(buttonText),
              );
            }),
            const SizedBox(width: TSizes.spaceBtwItems),
            // Button for filtering the available rooms
            ElevatedButton(
              onPressed: () => _showFilterDialog(context, controller),
              child: const Text('Filter'),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        const TDivider(),

        const SizedBox(height: TSizes.spaceBtwItems),

        // Displaying available rooms
        TGridLayout(
            itemCount: controller.availableRoomsId.length, // Updated to use roomsid
            itemBuilder: (context, index) {
              return TRoomCardVertical(
                  room: controller.availableRoomsId[index]); // Updated to use roomsid
            }),
      ],
    );
  }

  void _showFilterDialog(
      BuildContext context, AvailableRoomController controller) {
    // Implement filter dialog logic here
  }
}
