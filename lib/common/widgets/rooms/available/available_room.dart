import 'package:cwt_ecommerce_ui_kit/features/shop/controllers/booking_controller.dart';
import 'package:cwt_ecommerce_ui_kit/features/shop/screens/select_datetime/select_datetime.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../features/shop/controllers/available_room_controller.dart';
import '../../../../utils/constants/sizes.dart';
import '../../divider/t_divider.dart';
import '../../layouts/grid_layout.dart';
import '../room_card/room_card_vertical.dart';

class TAvailableRooms extends StatelessWidget {
  const TAvailableRooms({super.key});

  @override
  Widget build(BuildContext context) {
    final AvailableRoomController controller =
        Get.find<AvailableRoomController>();
    final BookingController bookingController = Get.find<BookingController>();
    controller.adjustTimeToNearestHalfHour();
    bookingController.fetchAllBookingsWithRoomDetails();
    controller.updateAvailableRooms();

    String formatTimeOfDay(BuildContext context, DateTime dateTime) {
      final format = DateFormat.jm(); // Use any format you need
      return format.format(dateTime);
    }

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
                  '$dateText, ${formatTimeOfDay(context, selectedStartTime)} - ${formatTimeOfDay(context, selectedEndTime)}';

              // Button for selecting the booking date and time
              return ElevatedButton(
                onPressed: () => Get.to(() => SelectDateTime()),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(buttonText),
                ),
              );
            }),
            const SizedBox(width: TSizes.spaceBtwItems),
            // Button for filtering the available rooms
            ElevatedButton(
              onPressed: () {
                // The logic for showing the filter dialog should be handled here or within a function called here.
              },
              child: const Text('Filter'),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        const TDivider(),

        const SizedBox(height: TSizes.spaceBtwItems),

        // Displaying available rooms
        Obx(
          () => TGridLayout(
              itemCount:
                  controller.availableRooms.length, // Updated to use roomsid
              itemBuilder: (context, index) {
                return TRoomCardVertical(
                    room: controller
                        .availableRooms[index]); // Updated to use roomsid
              }),
        ),
      ],
    );
  }
}
