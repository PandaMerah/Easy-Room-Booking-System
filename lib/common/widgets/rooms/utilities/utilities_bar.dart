// ignore_for_file: unused_import, unused_local_variable, prefer_const_constructors

import 'package:cwt_ecommerce_ui_kit/common/widgets/icons/t_circular_icon.dart';
import 'package:cwt_ecommerce_ui_kit/common/widgets/layouts/grid_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cwt_ecommerce_ui_kit/features/shop/controllers/room_controller.dart';
import 'package:cwt_ecommerce_ui_kit/features/shop/models/room_model.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../styles/shadows.dart';
import '../../custom_shapes/containers/rounded_container.dart';

class UtilitiesBar extends StatelessWidget {
  const UtilitiesBar({super.key, required this.roomId});

  final String roomId;

  @override
  Widget build(BuildContext context) {
    final Map<String, List<IconData>> roomIcons =
        RoomController.instance.getRoomIcons();

    List<IconData>? iconsForRoom = roomIcons[roomId];

    if (iconsForRoom == null || iconsForRoom.isEmpty) {
      return Text('No utilities available for this room');
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: iconsForRoom.map((icon) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: TSizes.xs), // Adjust the padding as needed
          child: Icon(icon),
        );
      }).toList(),
    );
  }
}
