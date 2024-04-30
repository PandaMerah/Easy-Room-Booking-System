import 'package:flutter/material.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  PolicyScreenState createState() => PolicyScreenState();
}

class PolicyScreenState extends State<PolicyScreen> {
  // Initial checkbox states
  bool allowBookingOnWeekend = true;
  bool onlyLecturersCanBook = true;
  bool limitBookDuration = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const TAppBar(title: Text('Policy Settings'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Don't allow booking on weekend"),
                  Checkbox(
                    value: allowBookingOnWeekend,
                    onChanged: (bool? value) {
                      setState(() {
                        allowBookingOnWeekend = value!;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Only lecturers can book the room"),
                  Checkbox(
                    value: onlyLecturersCanBook,
                    onChanged: (bool? value) {
                      setState(() {
                        onlyLecturersCanBook = value!;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Limit book duration to only 1 hour"),
                  Checkbox(
                    value: limitBookDuration,
                    onChanged: (bool? value) {
                      setState(() {
                        onlyLecturersCanBook = value!;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
