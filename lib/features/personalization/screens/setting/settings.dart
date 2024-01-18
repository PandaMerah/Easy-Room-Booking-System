// ignore_for_file: unused_import

import 'package:cwt_ecommerce_ui_kit/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:cwt_ecommerce_ui_kit/data/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../shop/controllers/dummy_data.dart';
import '../../../shop/screens/cart/cart.dart';
import '../../../shop/screens/order/order.dart';
import '../address/address.dart';
import '../profile/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthenticationRepository());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// AppBar
                  TAppBar(
                      title: Text('Account',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .apply(color: TColors.white))),

                  /// User Profile Card
                  TUserProfileTile(
                      user: TDummyData.user,
                      onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            /// -- Profile Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// -- Account  Settings
                  const TSectionHeading(
                      title: 'Account Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// -- My Addresses
                  // TSettingsMenuTile(
                  //   icon: Iconsax.safe_home,
                  //   title: 'My Addresses',
                  //   subTitle: 'Set shopping delivery address',
                  //   onTap: () => Get.to(() => const UserAddressScreen()),
                  // ),
                  /// -- My Cart
                  // TSettingsMenuTile(
                  //   icon: Iconsax.shopping_cart,
                  //   title: 'My Cart',
                  //   subTitle: 'Add, remove products and move to checkout',
                  //   onTap: () => Get.to(() => const CartScreen()),
                  // ),
                  /// -- My Orders
                  // TSettingsMenuTile(
                  //   icon: Iconsax.bag_tick,
                  //   title: 'My Orders',
                  //   subTitle: 'In-progress and Completed Orders',
                  //   onTap: () => Get.to(() => const OrderScreen()),
                  // ),
                  /// -- Bank Account
                  // const TSettingsMenuTile(
                  //     icon: Iconsax.bank,
                  //     title: 'Bank Account',
                  //     subTitle: 'Withdraw balance to registered bank account'),
                  /// -- My Coupons
                  // const TSettingsMenuTile(
                  //     icon: Iconsax.discount_shape,
                  //     title: 'My Coupons',
                  //     subTitle: 'List of all the discounted coupons'),
                  /// -- Account Privacy
                  const TSettingsMenuTile(
                      icon: Iconsax.security_card,
                      title: 'Account Privacy',
                      subTitle: 'Manage data usage and connected accounts'),

                  /// -- Notifications
                  TSettingsMenuTile(
                      icon: Iconsax.notification,
                      title: 'Notifications',
                      subTitle: 'Set any kind of notification message',
                      onTap: () {}),

                  /// -- App Settings
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(
                      title: 'App Settings (Developer Only)',
                      showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTile(
                      icon: Iconsax.notification,
                      title: 'Booking Policy',
                      subTitle: 'Adjust all the booking policy',
                      onTap: () {}),
                  // TSettingsMenuTile(
                  //   icon: Iconsax.location,
                  //   title: 'Geolocation',
                  //   subTitle: 'Set recommendation based on location',
                  //   trailing: Switch(value: true, onChanged: (value) {}),
                  // ),
                  // TSettingsMenuTile(
                  //   icon: Iconsax.security_user,
                  //   title: 'Safe Mode',
                  //   subTitle: 'Search result is safe for all ages',
                  //   trailing: Switch(value: false, onChanged: (value) {}),
                  // ),
                  // TSettingsMenuTile(
                  //   icon: Iconsax.image,
                  //   title: 'HD Image Quality',
                  //   subTitle: 'Set image quality to be seen',
                  //   trailing: Switch(value: false, onChanged: (value) {}),
                  // ),

                  /// -- Logout Button
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () => controller.logout(),
                          child: const Text('Logout'))),
                  const SizedBox(height: TSizes.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
