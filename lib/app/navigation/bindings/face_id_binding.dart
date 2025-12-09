import 'package:get/get.dart';

import '../../modules/face_id/controllers/face_id_controller.dart';

class FaceIdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaceIdController>(
      () => FaceIdController(),
    );
  }
}
