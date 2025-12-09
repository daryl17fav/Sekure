import 'package:get/get.dart';

import '../../modules/register_seller/controllers/register_seller_controller.dart';

class RegisterSellerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterSellerController>(
      () => RegisterSellerController(),
    );
  }
}
