import 'package:cwt_ecommerce_ui_kit/common/widgets/loaders/loaders.dart';
import 'package:cwt_ecommerce_ui_kit/data/repositories/authentication_repository.dart';
import 'package:cwt_ecommerce_ui_kit/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:cwt_ecommerce_ui_kit/utils/constants/image_strings.dart';
import 'package:cwt_ecommerce_ui_kit/utils/helpers/network_manager.dart';
import 'package:cwt_ecommerce_ui_kit/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  sendPasswordResetEmail() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Processing Your request', TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email link send to reset your password'.tr);

      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Processing Your request', TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email link send to reset your password'.tr);
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
