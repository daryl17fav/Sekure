import 'package:get/get.dart';

import '../../modules/touch_id_verify/controllers/touch_id_verify_controller.dart';

class TouchIdVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TouchIdVerifyController>(
      () => TouchIdVerifyController(),
    );
  }
}
