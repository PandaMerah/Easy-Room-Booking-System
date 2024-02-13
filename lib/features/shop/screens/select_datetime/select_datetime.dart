import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/divider/t_divider.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/available_room_controller.dart';
import 'widgets/calendar_widget.dart';
import 'widgets/time_widget.dart';

class SelectDateTime extends StatelessWidget {
  SelectDateTime({super.key});

  final AvailableRoomController controller =
      Get.find<AvailableRoomController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const TAppBar(title: Text("Booking Details"), showBackArrow: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              // Accessing date and time directly from the controller
              final selectedDate = controller.selectedDate.value;
              final selectedStartTime = controller.selectedStartTime.value;
              final selectedEndTime = controller.selectedEndTime.value;
              String dateText =
                  DateFormat('EEE, dd/MM/yyyy').format(selectedDate);
              String formattedStartTime = DateFormat.jm()
                  .format(selectedStartTime); // For 12-hour format
              String formattedEndTime =
                  DateFormat.jm().format(selectedEndTime); // For 12-hour format

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: [
                    Text(dateText),
                    Text(formattedStartTime),
                  ]),
                  const Text("→"),
                  Column(children: [
                    Text(dateText),
                    Text(formattedEndTime),
                  ]),
                ],
              );
            }),
            const TCalendar(),
            const TDivider(),
            const TTimePicker(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.back(),
            child: const Text('Proceed'),
          ),
        ),
      ),
    );
  }
}
