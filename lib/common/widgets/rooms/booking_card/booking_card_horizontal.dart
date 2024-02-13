// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../styles/shadows.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../images/t_rounded_image.dart';
import '../../texts/t_product_title_text.dart';

import '../../../../features/shop/controllers/booking_controller.dart';
import '../../../../features/shop/models/booking_model.dart';
import '../../../../features/shop/models/room_model.dart';

class BookingCardHorizontal extends StatelessWidget {
  final BookingModel booking;
  final RoomModel room;

  const BookingCardHorizontal({
    super.key,
    required this.booking,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    String formattedDate = DateFormat('yyyy-MM-dd').format(booking.date);
    String formattedStartTime = DateFormat('HH:mm').format(booking.startTime);
    String formattedEndTime = DateFormat('HH:mm').format(booking.endTime);
    // Calculate the duration of the booking
    String duration = _calculateDuration(booking.startTime, booking.endTime);

    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        boxShadow: [TShadowStyle.verticalProductShadow],
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: dark ? TColors.darkerGrey : TColors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Room Thumbnail
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

          TRoundedContainer(
            // height: 200,
            margin: const EdgeInsets.only(
                left: TSizes.md, top: TSizes.sm, bottom: TSizes.sm),
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: dark ? TColors.dark : TColors.light,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  room.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text('Date: $formattedDate'),
                Text('Time: $formattedStartTime - $formattedEndTime'),
                Text('Duration: $duration'),
                Text('Status: ${booking.status}'),
                // Add more details as needed
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _calculateDuration(DateTime startTime, DateTime endTime) {
    // Calculate Duration directly with DateTime
    final duration = endTime.difference(startTime);

    // Format Duration - e.g., "2 hours, 30 minutes"
    String formattedDuration = '';
    if (duration.inHours > 0) {
      formattedDuration +=
          '${duration.inHours} hour${duration.inHours > 1 ? 's' : ''}';
    }
    int minutes = duration.inMinutes % 60;
    if (minutes > 0) {
      if (formattedDuration.isNotEmpty) formattedDuration += ', ';
      formattedDuration += '$minutes minute${minutes > 1 ? 's' : ''}';
    }

    return formattedDuration;
  }
}
