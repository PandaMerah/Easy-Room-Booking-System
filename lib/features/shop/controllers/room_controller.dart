import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../common/widgets/loaders/loaders.dart';
import '../../../utils/constants/sizes.dart';
import '../models/room_model.dart';

class RoomController extends GetxController {
  static RoomController get instance => Get.find();

  RxList<RoomModel> allRooms = <RoomModel>[].obs;
  final isLoading = false.obs;

  final rooms = <RoomModel>[].obs;
  // Ini untuk controller get data daripada backend terhadap tempahan yang dah ada pastu buat decision sama ada dah booking atau belum guna if else
  final utilities = <String>{}.obs;
  RxString selectedRoomImage = ''.obs;
  RxString availability = ''.obs;
  final favorites = <String, RxBool>{}.obs;

  /// -- Initialize Rooms from your backend
  @override
  void onInit() {
    fetchRooms();
    super.onInit();
  }

  /// Get All Rooms from Firebase
  Future<void> fetchRooms() async {
    isLoading.value = true;
    try {
      // Fetch Rooms from Firebase
      final querySnapshot =
          await FirebaseFirestore.instance.collection('Rooms').get();
      final rooms =
          querySnapshot.docs.map((doc) => RoomModel.fromSnapshot(doc)).toList();

      // Update The Rooms list
      allRooms.assignAll(rooms);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
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
                child: Image.network(image),
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

    for (var room in allRooms) {
      // Make sure to iterate over allRooms
      List<IconData> icons = [];

      for (var utility in room.utilities) {
        IconData? icon = _getIconData(utility);
        if (icon != null) {
          icons.add(icon);
        }
      }

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
  }
}
