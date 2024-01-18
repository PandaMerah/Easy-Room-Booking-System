import 'package:cwt_ecommerce_ui_kit/common/widgets/rooms/room_card/room_card_vertical.dart';
import 'package:cwt_ecommerce_ui_kit/features/shop/screens/home/widgets/header_search_container.dart';
import 'package:cwt_ecommerce_ui_kit/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';
import '../../controllers/dummy_data.dart';
import '../../controllers/home_controller.dart';
import '../all_rooms/all_rooms.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final rooms = controller.getRooms();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            const TPrimaryHeaderContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// -- Appbar
                  SizedBox(height: TSizes.spaceBtwSections / 2),
                  THomeAppBar(),
                  SizedBox(height: TSizes.spaceBtwSections),

                  /// -- Searchbar
                  TSearchContainer(text: 'Search a room', showBorder: true),
                  SizedBox(height: TSizes.spaceBtwSections * 2),
                ],
              ),
            ),

            /// -- Body
            Container(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// -- Popular Rooms
                  TSectionHeading(
                    title: TTexts.popularRooms,
                    onPressed: () => Get.to(() => AllAvailableRooms(
                        title: "Available Rooms",
                        bookings: TDummyData.bookings)),
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),
                  TGridLayout(
                    itemCount: 3, //featuredProducts.length
                    itemBuilder: (_, index) =>
                        TRoomCardVertical(room: rooms[index]),
                  ),

                  const SizedBox(height: TSizes.spaceBtwSections * 2),
                  SizedBox(
                      height: TDeviceUtils.getBottomNavigationBarHeight() +
                          TSizes.defaultSpace),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
