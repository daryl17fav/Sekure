import 'package:get/get.dart';

import '../../modules/create_submission/controllers/create_submission_controller.dart';

class CreateSubmissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateSubmissionController>(
      () => CreateSubmissionController(),
    );
  }
}
