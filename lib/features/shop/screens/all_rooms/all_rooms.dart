import 'package:cwt_ecommerce_ui_kit/common/widgets/rooms/available/available_room.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/booking_model.dart';

class AllAvailableRooms extends StatelessWidget {
  const AllAvailableRooms(
      {super.key, required this.title, required this.bookings});

  final String title;
  final List<BookingModel> bookings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text(title), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: TAvailableRooms(bookings: bookings),
        ),
      ),
    );
  }
}
