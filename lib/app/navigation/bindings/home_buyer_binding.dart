import 'package:get/get.dart';

import '../../modules/home_buyer/controllers/home_buyer_controller.dart';

class HomeBuyerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeBuyerController>(
      () => HomeBuyerController(),
    );
  }
}
