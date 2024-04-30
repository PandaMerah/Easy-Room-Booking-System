import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import '../../../../common/widgets/divider/t_divider.dart';
import '../../../../common/widgets/rooms/utilities/utilities_bar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/available_room_controller.dart';
import '../../models/room_model.dart';
import '../proceed_booking.dart/proceed_booking.dart';
import '../select_datetime/select_datetime.dart';
import 'widgets/room_detail_image_slider.dart';

class RoomDetailScreen extends StatelessWidget {
  RoomDetailScreen({super.key, required this.room});

  final RoomModel room;
  final AvailableRoomController controller =
      Get.find<AvailableRoomController>();

  @override
  Widget build(BuildContext context) {
    String calculateDuration(DateTime startTime, DateTime endTime) {
      final duration = endTime.difference(startTime);
      // Convert duration to hours, rounding to two decimal places
      final durationInHours = duration.inMinutes / 60.0;
      return durationInHours.toStringAsFixed(2);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TRoomImageSlider(room: room),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.defaultSpace,
                  vertical: TSizes.spaceBtwSections / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(room.name,
                          style: Theme.of(context).textTheme.titleLarge),
                      const Text("Available")
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections / 4),
                  UtilitiesBar(roomId: room.id),
                ],
              ),
            ),
            const TDivider(),
            Obx(() {
              final selectedDate = controller.selectedDate.value;
              final selectedStartTime = controller.selectedStartTime.value;
              final selectedEndTime = controller.selectedEndTime.value;
              String dateText =
                  DateFormat('EEE, dd/MM/yyyy').format(selectedDate);
              String formattedStartTime = DateFormat.jm()
                  .format(selectedStartTime); // For 12-hour format
              String formattedEndTime =
                  DateFormat.jm().format(selectedEndTime); // For 12-hour format
              String duration =
                  calculateDuration(selectedStartTime, selectedEndTime);

              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: TSizes.defaultSpace,
                    vertical: TSizes.spaceBtwSections / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Booking Details",
                            style: Theme.of(context).textTheme.titleMedium),
                        GestureDetector(
                          onTap: () => Get.to(() => SelectDateTime()),
                          child: Text("Change",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor)),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections / 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Booking Date"),
                        Text(dateText),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems / 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Booking Time"),
                        Text("$formattedStartTime - $formattedEndTime"),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems / 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Booking Duration"),
                        Text("$duration hours"),
                      ],
                    ),
                  ],
                ),
              );
            }),
            const TDivider(),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.defaultSpace,
                  vertical: TSizes.spaceBtwSections / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Usage Guide",
                      style: Theme.of(context).textTheme.titleMedium),
                  const ReadMoreText(
                    "1. Pick the date and time of the room that you want to book\n2. Click Proceed Booking\n3. Confirm you booking details\n4. Click Book Now to book the room that you have selected\n5. Wait until you get notification saying that your room is available to use right now\n6. See the person-in-charge of the room to get the key\n7. Use the room\n8.Clean the room before returning the key to the person-in-charge\n9. Repeat the step when you want to book again in the future.",
                    trimLines: 3,
                    colorClickableText: Colors.pink,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Show less',
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.to(() => ProceedBooking(room: room)),
            child: const Text('Proceed'),
          ),
        ),
      ),
    );
  }
}
