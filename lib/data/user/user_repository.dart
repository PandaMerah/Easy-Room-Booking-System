import 'package:cwt_ecommerce_ui_kit/data/repositories/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../features/personalization/models/user_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save User Record
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      // Log the exception for debugging
      if (kDebugMode) {
        print('Error saving user record: $e');
      }
      throw 'Failed to save user data. Please try again.';
    }
  }

  // Fetch User Details based on user id
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      // Log the exception for debugging
      if (kDebugMode) {
        print('Error saving user record: $e');
      }
      throw 'Failed to save user data. Please try again.';
    }
  }

  // Update user details based on uid
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection('Users')
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      // Log the exception for debugging
      if (kDebugMode) {
        print('Error saving user record: $e');
      }
      throw 'Failed to save user data. Please try again.';
    }
  }

  // Update single field in specific user collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      // Log the exception for debugging
      if (kDebugMode) {
        print('Error saving user record: $e');
      }
      throw 'Failed to save user data. Please try again.';
    }
  }

  // Update single field in specific user collection
  Future<void> removeUserRecord(userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      // Log the exception for debugging
      if (kDebugMode) {
        print('Error saving user record: $e');
      }
      throw 'Failed to save user data. Please try again.';
    }
  }
}
// 