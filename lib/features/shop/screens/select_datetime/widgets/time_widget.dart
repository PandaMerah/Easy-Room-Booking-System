// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';
import '../../../controllers/available_room_controller.dart'; // Import your controller

class TTimePicker extends StatefulWidget {
  const TTimePicker({super.key});

  @override
  _TTimePickerState createState() => _TTimePickerState();
}

class _TTimePickerState extends State<TTimePicker> {
  final AvailableRoomController controller =
      Get.find<AvailableRoomController>();
  bool _isSettingStartTime = true; // Flag to toggle between start and end time

  @override
  Widget build(BuildContext context) {
    // Unique keys based on the time setting mode
    Key startTimeKey = const Key('StartTimePicker');
    Key endTimeKey = const Key('EndTimePicker');

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () => setState(() => _isSettingStartTime = true),
              child: Text(
                "Start Time",
                style: TextStyle(
                  color: _isSettingStartTime ? Colors.black : Colors.grey,
                ),
              ),
            ),
            InkWell(
              onTap: () => setState(() => _isSettingStartTime = false),
              child: Text(
                "End Time",
                style: TextStyle(
                  color: _isSettingStartTime ? Colors.grey : Colors.black,
                ),
              ),
            )
          ],
        ),
        TimePickerSpinner(
          key: _isSettingStartTime
              ? startTimeKey
              : endTimeKey, // Use unique keys
          is24HourMode: false,
          itemHeight: 50,
          time: _isSettingStartTime
              ? controller.selectedStartTime.value.toDateTime()
              : controller.selectedEndTime.value.toDateTime(),
          onTimeChange: (time) {
            setState(() {
              TimeOfDay selectedTime = TimeOfDay.fromDateTime(time);
              if (_isSettingStartTime) {
                controller.selectedStartTime.value = selectedTime;
              } else {
                controller.selectedEndTime.value = selectedTime;
              }
            });
          },
        )
      ],
    );
  }
}

extension on TimeOfDay {
  DateTime toDateTime() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }
}
