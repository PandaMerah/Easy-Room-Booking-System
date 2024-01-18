import 'package:cwt_ecommerce_ui_kit/common/widgets/rooms/utilities/utilities_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../common/widgets/divider/t_divider.dart';
import '../../controllers/available_room_controller.dart'; // Import your controller
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/room_model.dart';

class ProceedBooking extends StatelessWidget {
  const ProceedBooking({super.key, required this.roomId});
  final String roomId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AvailableRoomController>();
    final RoomModel room = controller.findRoomById(roomId);
    final roomName = room.name;

    final selectedDate = controller.selectedDate.value;
    final selectedStartTime = controller.selectedStartTime.value;
    final selectedEndTime = controller.selectedEndTime.value;

    String formattedDate = DateFormat('EEE, dd/MM/yyyy').format(selectedDate);
    String timeRange =
        "${selectedStartTime.format(context)} - ${selectedEndTime.format(context)}";

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
                      Text(roomName,
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      UtilitiesBar(roomId: roomId)
                    ],
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
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
                  const Text("Duration:  hours") // Do the duration calculation here
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
                  const Text("Lorem Ip Supm"),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  Text("Notes", style: Theme.of(context).textTheme.titleMedium),
                  const Text("Lorem Ip Supm"),
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
            onPressed: () => Get.to(() => ProceedBooking(roomId: roomId)),
            child: const Text('Book Now'),
          ),
        ),
      ),
    );
  }
}
