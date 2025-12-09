import 'package:get/get.dart';

import '../../modules/disputes/controllers/disputes_controller.dart';

class DisputesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DisputesController>(
      () => DisputesController(),
    );
  }
}
