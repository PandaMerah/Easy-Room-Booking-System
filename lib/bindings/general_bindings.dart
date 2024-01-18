import 'package:get/get.dart';

import '../features/shop/controllers/available_room_controller.dart';
import '../features/shop/controllers/brand_controller.dart';
import '../features/personalization/controllers/address_controller.dart';
import '../features/personalization/controllers/user_controller.dart';
import '../features/shop/controllers/cart_controller.dart';
import '../features/shop/controllers/categories_controller.dart';
import '../features/shop/controllers/checkout_controller.dart';
import '../features/shop/controllers/proceed_booking_controller.dart';
import '../features/shop/controllers/product_controller.dart';
import '../features/shop/controllers/room_controller.dart';
import '../utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    /// -- Product Controllers
    Get.put(AvailableRoomController());
    Get.put(ProceedBookingController());
    Get.put(RoomController());
    Get.put(ProductController());
    Get.put(CartController());
    Get.put(CheckoutController());
    Get.put(CategoryController());
    Get.put(BrandController());

    /// -- User Controllers
    Get.put(UserController());
    Get.put(AddressController());

    /// -- Network Manger
    Get.put(NetworkManager());
  }
}
