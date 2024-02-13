import 'package:cwt_ecommerce_ui_kit/common/widgets/rooms/available/available_room.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';

class AllAvailableRooms extends StatelessWidget {
  const AllAvailableRooms({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text(title), showBackArrow: true),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: TAvailableRooms(),
        ),
      ),
    );
  }
}
