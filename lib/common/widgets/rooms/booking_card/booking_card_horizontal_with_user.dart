import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../features/shop/models/booking_model.dart';
// Import paths need to be adjusted to fit your project structure

class BookingCardHorizontalWithUser extends StatelessWidget {
  const BookingCardHorizontalWithUser({
    super.key,
    required this.booking,
    // Since room details are included in booking, you might not need to pass room separately
  });
  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark; // Updated for dark mode detection
    String formattedDate = DateFormat('dd.MM.yyyy').format(booking.date);
    String formattedStartTime = DateFormat('h:mm a').format(booking.startTime);
    String formattedEndTime = DateFormat('h:mm a').format(booking.endTime);
    String duration = _calculateDuration(booking.startTime, booking.endTime);

    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 3, color: Colors.black.withOpacity(0.1))], // Simplified shadow
        borderRadius: BorderRadius.circular(8), // Adjusted for consistency
        color: dark ? Colors.grey[850] : Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Assuming room.thumbnail is a valid URL
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), // Added for consistency
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(booking.roomDetails?.thumbnail ?? ''), // Using roomDetails from booking
              ),
            ),
          ),
          Expanded( // Wrapped in Expanded to prevent overflow
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0), // Adjusted padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    booking.roomDetails?.name ?? 'Room Name Not Available',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text('User: ${booking.userDetails?.fullName ?? 'User Name Not Available'}'),
                  Text('Date: $formattedDate'),
                  Text('Time: $formattedStartTime - $formattedEndTime'),
                  Text('Duration: $duration'),
                  // Consider adding more details or actions here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _calculateDuration(DateTime startTime, DateTime endTime) {
    final duration = endTime.difference(startTime);
    String formattedDuration = '';
    if (duration.inHours > 0) {
      formattedDuration += '${duration.inHours} hour${duration.inHours > 1 ? 's' : ''}';
    }
    int minutes = duration.inMinutes % 60;
    if (minutes > 0) {
      if (formattedDuration.isNotEmpty) formattedDuration += ', ';
      formattedDuration += '$minutes minute${minutes > 1 ? 's' : ''}';
    }
    return formattedDuration;
  }
}
