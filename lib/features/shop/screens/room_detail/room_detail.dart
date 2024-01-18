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
                        Text(
                            "${selectedStartTime.format(context)} - ${selectedEndTime.format(context)}"),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems / 6),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Booking Duration"),
                        Text("2 Hours"),
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
                    "Your room usage guide text here...",
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
            onPressed: () => Get.to(() => ProceedBooking(roomId: room.id,)),
            child: const Text('Proceed'),
          ),
        ),
      ),
    );
  }
}
