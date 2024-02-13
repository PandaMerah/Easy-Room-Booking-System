import 'package:cwt_ecommerce_ui_kit/features/shop/models/room_model.dart';
import 'package:cwt_ecommerce_ui_kit/utils/exceptions/firebase_exceptions.dart';
import 'package:cwt_ecommerce_ui_kit/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomRepository extends GetxController {
  static RoomRepository get intstance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<RoomModel>> getAllRooms() async {
    try {
      final snapshot = await _db.collection('Rooms').get();
      final list = snapshot.docs
          .map((document) => RoomModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
