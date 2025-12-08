import 'package:get/get.dart';

import '../controllers/register_seller_controller.dart';

class RegisterSellerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterSellerController>(
      () => RegisterSellerController(),
    );
  }
}
