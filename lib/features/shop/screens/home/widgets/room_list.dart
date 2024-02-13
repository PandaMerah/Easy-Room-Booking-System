import 'package:cwt_ecommerce_ui_kit/common/widgets/shimmer/shimmer.dart';
import 'package:cwt_ecommerce_ui_kit/features/shop/controllers/room_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/rooms/room_card/room_card_vertical.dart';

class RoomList extends StatelessWidget {
  const RoomList({super.key});

  @override
  Widget build(BuildContext context) {
    final roomController = Get.find<RoomController>();

    return Obx(() {
      if (roomController.isLoading.value) {
        return const TShimmerEffect(
            width: 55, height: 55, radius: 55); // Loading indicator
      }

      return TGridLayout(
        itemCount: roomController.allRooms.length,
        itemBuilder: (_, index) {
          return TRoomCardVertical(
              room: roomController
                  .allRooms[index]); // Make sure to return the widget
        },
      );
    });
  }
}
