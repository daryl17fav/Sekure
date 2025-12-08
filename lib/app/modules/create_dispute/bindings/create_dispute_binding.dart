import 'package:get/get.dart';

import '../controllers/create_dispute_controller.dart';

class CreateDisputeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateDisputeController>(
      () => CreateDisputeController(),
    );
  }
}
