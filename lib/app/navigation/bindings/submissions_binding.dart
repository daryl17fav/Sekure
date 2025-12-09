import 'package:get/get.dart';

import '../../modules/submissions/controllers/submissions_controller.dart';

class SubmissionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmissionsController>(
      () => SubmissionsController(),
    );
  }
}
