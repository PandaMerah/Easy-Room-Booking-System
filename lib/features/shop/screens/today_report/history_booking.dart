import 'package:cwt_ecommerce_ui_kit/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/layouts/small_grid_layout.dart';
import '../../../../common/widgets/rooms/booking_card/booking_card_horizontal_with_user.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/history_booking_controller.dart';
import '../../models/booking_model.dart';

class HistoryBooking extends StatelessWidget {
  const HistoryBooking({super.key});

  @override
  Widget build(BuildContext context) {
    final HistoryBookingController historyBookingController =
        Get.find<HistoryBookingController>();
    historyBookingController.fetchAllBookingsWithRoomDetails();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const TAppBar(
          title: Text('All Bookings (Today)'),
          showBackArrow: true,
        ),
        body: Column(
          children: [
            const TTabBar(
              tabs: [
                Tab(text: 'Active'),
                Tab(text: 'Upcoming'),
                Tab(text: 'Ended'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Obx(() => buildBookingGrid(
                      historyBookingController.activeBookings)),
                  Obx(() => buildBookingGrid(
                      historyBookingController.upcomingBookings)),
                  Obx(() =>
                      buildBookingGrid(historyBookingController.endedBookings)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBookingGrid(RxList<BookingModel> bookings) {
    if (bookings.isEmpty) {
      return const Center(child: Text("No bookings found"));
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: TSmallGridLayout(
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            final BookingModel booking = bookings[index];
            return BookingCardHorizontalWithUser(booking: booking);
          },
        ),
      ),
    );
  }
}
