import 'package:cwt_ecommerce_ui_kit/common/widgets/loaders/loaders.dart';
import 'package:cwt_ecommerce_ui_kit/features/personalization/controllers/user_controller.dart';
import 'package:cwt_ecommerce_ui_kit/features/personalization/screens/profile/profile.dart';
import 'package:cwt_ecommerce_ui_kit/utils/constants/image_strings.dart';
import 'package:cwt_ecommerce_ui_kit/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../data/user/user_repository.dart';
import '../../../utils/helpers/network_manager.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initilizeNames();
    super.onInit();
  }

  Future<void> initilizeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'We are updating your information', TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!updateUserNameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim()
      };
      await userRepository.updateSingleField(name);

      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'Contratulations', message: 'Your name has been updated.');

      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
