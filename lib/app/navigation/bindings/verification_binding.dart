import 'package:get/get.dart';

import '../../modules/verification/controllers/verification_controller.dart';

class VerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationController>(
      () => VerificationController(),
    );
  }
}
