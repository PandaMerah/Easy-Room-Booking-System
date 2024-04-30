// ignore_for_file: unused_import, unused_local_variable, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cwt_ecommerce_ui_kit/common/widgets/rooms/booking_card/booking_card_horizontal.dart';
import 'package:cwt_ecommerce_ui_kit/features/shop/controllers/home_controller.dart';
import 'package:cwt_ecommerce_ui_kit/features/shop/screens/store/widgets/category_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/layouts/small_grid_layout.dart';
import '../../controllers/booking_controller.dart';
import '../../models/booking_model.dart';
import '../../models/room_model.dart';
import '../../controllers/room_controller.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/brands/brand_card.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/dummy_data.dart';
import '../../controllers/store_controller.dart';
import '../brand/all_brands.dart';
import '../brand/brand.dart';
import '../home/widgets/header_search_container.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingController bookingController = Get.find<BookingController>();
    final roomController = Get.put(HomeController());
    final List<RoomModel> rooms = roomController.getRooms();
    bookingController.fetchAllBookingsWithRoomDetails();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TAppBar(
          title: Text('Bookings',
              style: Theme.of(context).textTheme.headlineMedium),
        ),
        body: Column(
          children: [
            TTabBar(
              tabs: [
                Tab(text: 'Active'),
                Tab(text: 'Upcoming'),
                Tab(text: 'Ended'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Obx(() => buildBookingGrid(bookingController.activeBookings)),
                  Obx(() =>
                      buildBookingGrid(bookingController.upcomingBookings)),
                  Obx(() => buildBookingGrid(bookingController.endedBookings)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBookingGrid(RxList<BookingModel> bookings) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: TSmallGridLayout(
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            final BookingModel booking = bookings[index];
            final RoomModel room = booking.roomDetails ?? RoomModel.empty();
            return BookingCardHorizontal(booking: booking, room: room);
          },
        ),
      ),
    );
  }
}
