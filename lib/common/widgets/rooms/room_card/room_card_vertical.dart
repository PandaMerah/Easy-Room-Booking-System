import 'package:cwt_ecommerce_ui_kit/features/shop/screens/room_detail/room_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cwt_ecommerce_ui_kit/common/widgets/rooms/utilities/utilities_bar.dart';
import '../../../../features/shop/models/room_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../styles/shadows.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../images/t_rounded_image.dart';
import '../../texts/t_product_title_text.dart';
import '../../products/favourite_icon/favourite_icon.dart';

class TRoomCardVertical extends StatelessWidget {
  const TRoomCardVertical({super.key, required this.room});

  final RoomModel room;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => RoomDetailScreen(
          room: room)), // Ubah jadi bila tekan pergi dekat room details

      /// Container with side paddings, color, edges, radius and shadow.
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Thumbnail, Wishlist Button, Discount Tag
            TRoundedContainer(
              height: 130,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  /// -- Thumbnail Image
                  Center(
                      child: TRoundedImage(
                    imageUrl: room.thumbnail,
                    applyImageRadius: true,
                  )),

                  /// -- Favourite Icon Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: TFavouriteIcon(
                        productId: room.id), // Ubah jadi add favorite room
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// -- Details
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm, right: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TProductTitleText(title: room.name),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 150,
                        child: UtilitiesBar(
                          roomId: room.id,
                        ),
                      ),
                      const SizedBox(width: TSizes.spaceBtwItems * 5),
                      const Text('Available') //Give me tick icon in text
                      //
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
