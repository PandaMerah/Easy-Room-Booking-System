import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../common/widgets/products/favourite_icon/favourite_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/room_controller.dart';
import '../../../models/room_model.dart';
// import '../../../controllers/product_controller.dart';
// import '../../../models/product_model.dart';

class TRoomImageSlider extends StatelessWidget {
  const TRoomImageSlider({super.key, required this.room});

  final RoomModel room;

  @override
  Widget build(BuildContext context) {
    final controller = RoomController.instance;
    final isDark = THelperFunctions.isDarkMode(context);
    final images = controller.getAllRoomImages(room);
    return TCurvedEdgesWidget(
      child: Container(
        color: isDark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            /// Main Large Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace * 2),
                child: Center(
                  child: Obx(() {
                    final image = controller.selectedRoomImage.value.isEmpty
                        ? room.thumbnail
                        : controller.selectedRoomImage.value;
                    return GestureDetector(
                        onTap: () => controller.showEnlargedImage(image),
                        child: Image.network(
                          image,
                          fit: BoxFit.contain,
                        ));
                  }),
                ),
              ),
            ),

            /// Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: images.length,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: TSizes.spaceBtwItems),
                  itemBuilder: (_, index) {
                    return Obx(
                      () {
                        final imageSelected =
                            controller.selectedRoomImage.value == images[index];
                        return TRoundedImage(
                          width: 80,
                          fit: BoxFit.contain,
                          imageUrl: images[index],
                          isNetworkImage: true,
                          padding: const EdgeInsets.all(TSizes.sm),
                          backgroundColor:
                              isDark ? TColors.dark : TColors.white,
                          onPressed: () => controller.selectedRoomImage.value =
                              images[index],
                          border: Border.all(
                              color: imageSelected
                                  ? TColors.primary
                                  : Colors.transparent),
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            /// Appbar Icons
            TAppBar(
                showBackArrow: true,
                actions: [TFavouriteIcon(productId: room.id)]),
          ],
        ),
      ),
    );
  }
}
