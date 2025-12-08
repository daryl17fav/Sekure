import 'package:get/get.dart';

import '../controllers/touch_id_verify_controller.dart';

class TouchIdVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TouchIdVerifyController>(
      () => TouchIdVerifyController(),
    );
  }
}
