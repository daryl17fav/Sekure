import 'package:get/get.dart';

import '../../modules/touch_id_auth/controllers/touch_id_auth_controller.dart';

class TouchIdAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TouchIdAuthController>(
      () => TouchIdAuthController(),
    );
  }
}
