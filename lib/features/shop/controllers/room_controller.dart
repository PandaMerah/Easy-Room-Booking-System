import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/sizes.dart';
import '../models/room_model.dart';
import 'dummy_data.dart';

class RoomController extends GetxController {
  static RoomController get instance => Get.find();

  final rooms = <RoomModel>[].obs;
  // Ini untuk controller get data daripada backend terhadap tempahan yang dah ada pastu buat decision sama ada dah booking atau belum guna if else
  final utilities = <String>{}.obs;
  RxString selectedRoomImage = ''.obs;
  RxString availability = ''.obs;
  final favorites = <String, RxBool>{}.obs;

  /// -- Initialize Rooms from your backend
  @override
  void onInit() {
    // You can initialize rooms from your backend here, but for this example, we're using dummy data.
    rooms.value = TDummyData.rooms;
    super.onInit();
  }

  /// -- Get all room images
  List<String> getAllRoomImages(RoomModel room) {
    // Use Set to add unique images only
    Set<String> images = {};

    // Load thumbnail image
    images.add(room.thumbnail);
    // Assign Thumbnail as Selected Image
    selectedRoomImage.value = room.thumbnail;

    // Get all images from the Product Model if not null.
    if (room.images != null) {
      images.addAll(room.images!);
    }

    return images.toList();
  }

  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
      () => Dialog.fullscreen(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: TSizes.defaultSpace * 2,
                    horizontal: TSizes.defaultSpace),
                child: Image(image: AssetImage(image)),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 150,
                  child: OutlinedButton(
                      onPressed: () => Get.back(), child: const Text('Close')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// -- Get all room icon
  Map<String, List<IconData>> getRoomIcons() {
    Map<String, List<IconData>> roomIcons = {};

    for (var room in rooms) {
      List<IconData> icons = room.utilities
          .map((utility) => _getIconData(utility as String))
          .where((icon) => icon != null)
          .cast<IconData>()
          .toList();
      roomIcons[room.id] = icons;
    }

    return roomIcons;
  }

  IconData? _getIconData(String utility) {
    // Map utility strings to IconData. Adjust this mapping based on your actual utilities
    switch (utility) {
      case 'wifi':
        return Iconsax.wifi;
      case 'truck':
        return Iconsax.truck;
      // Add other cases for different utilities
      default:
        return null; // Default icon if utility is not recognized
    }

    /// -- Get All Utilities
    // Set<String> getAllUtilities(RoomModel room) {
    //   Set<String> utilities = {};

    //   for (var room in rooms) {
    //     utilities.addAll(room.utilities as Iterable<String>);
    //   }
    //   return utilities;
    // }
  }
}
