import 'package:get/get.dart';

import '../../modules/role_selection/controllers/role_selection_controller.dart';

class RoleSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoleSelectionController>(
      () => RoleSelectionController(),
    );
  }
}
