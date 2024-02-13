import 'package:cwt_ecommerce_ui_kit/common/widgets/rooms/utilities/utilities_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../common/widgets/divider/t_divider.dart';
import '../../controllers/available_room_controller.dart'; // Import your controller
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/book_room_controller.dart';
import '../../models/room_model.dart';

class ProceedBooking extends StatelessWidget {
  ProceedBooking({super.key, required this.room});

  final RoomModel room;
  final controller = Get.find<AvailableRoomController>();
  final bookController = Get.find<BookRoomController>();
  // final RoomModel room = controller.findRoomById(roomId);

  @override
  Widget build(BuildContext context) {
    final selectedDate = controller.selectedDate.value;
    final selectedStartTime = controller.selectedStartTime.value;
    final selectedEndTime = controller.selectedEndTime.value;

    String formattedDate = DateFormat('EEE, dd/MM/yyyy').format(selectedDate);
    String formattedStartTime = DateFormat('HH:mm').format(selectedStartTime);
    String formattedEndTime = DateFormat('HH:mm').format(selectedEndTime);

    String timeRange = "$formattedStartTime - $formattedEndTime";

    String calculateDuration(DateTime startTime, DateTime endTime) {
      final duration = endTime.difference(startTime);
      // Convert duration to hours, rounding to two decimal places
      final durationInHours = duration.inMinutes / 60.0;
      return durationInHours.toStringAsFixed(2);
    }

    String duration = calculateDuration(selectedStartTime, selectedEndTime);

    return Scaffold(
      appBar: const TAppBar(title: Text('Booking Review'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(room.name,
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      UtilitiesBar(roomId: room.id)
                    ],
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            room.thumbnail), // Replace with your image provider
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections / 2),
              const TDivider(),
              const SizedBox(height: TSizes.spaceBtwSections / 2),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Booking Details",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  Text("Date: $formattedDate"),
                  Text("Time: $timeRange"),
                  Text(
                      "Duration: $duration hours") // Do the duration calculation here
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections / 2),
              const TDivider(),
              const SizedBox(height: TSizes.spaceBtwSections / 2),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Additional Details",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text("Booking Title",
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: TSizes.spaceBtwInputFields / 2),
                  TextField(
                    onChanged: (value) => controller.bookingTitle.value = value,
                    decoration: const InputDecoration(labelText: "Optional"),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  Text("Notes", style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: TSizes.spaceBtwInputFields / 2),
                  TextField(
                    onChanged: (value) => controller.bookingNotes.value = value,
                    decoration: const InputDecoration(labelText: "Optional"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (() => bookController.bookRoom(room.id)),
            child: const Text('Book Now'),
          ),
        ),
      ),
    );
  }
}
