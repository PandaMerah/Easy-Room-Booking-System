import 'package:cwt_ecommerce_ui_kit/common/widgets/texts/section_heading.dart';
import 'package:cwt_ecommerce_ui_kit/data/user/user_repository.dart';
import 'package:cwt_ecommerce_ui_kit/features/shop/screens/home/widgets/header_search_container.dart';
import 'package:cwt_ecommerce_ui_kit/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';
import '../../controllers/available_room_controller.dart';
import '../../controllers/booking_controller.dart';
import '../all_rooms/all_rooms.dart';
import 'widgets/room_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final availableRoomController = Get.find<AvailableRoomController>();
    final BookingController bookingController = Get.find<BookingController>();
    final UserRepository userRepository = Get.find<UserRepository>();
    availableRoomController.adjustTimeToNearestHalfHour();
    bookingController.fetchAllBookingsWithRoomDetails();
    availableRoomController.updateAvailableRooms();
    userRepository.fetchUserDetails();

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
                    onPressed: () => Get.to(() => const AllAvailableRooms(
                          title: "Available Rooms",
                        )),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const RoomList(),
                  const SizedBox(height: TSizes.spaceBtwSections * 2),
                  SizedBox(
                    height: TDeviceUtils.getBottomNavigationBarHeight() +
                        TSizes.defaultSpace,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
