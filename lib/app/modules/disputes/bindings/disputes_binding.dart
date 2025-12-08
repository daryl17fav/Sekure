import 'package:get/get.dart';

import '../controllers/disputes_controller.dart';

class DisputesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DisputesController>(
      () => DisputesController(),
    );
  }
}
