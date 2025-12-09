import 'package:get/get.dart';

import '../../modules/loyalty_points/controllers/loyalty_points_controller.dart';

class LoyaltyPointsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoyaltyPointsController>(
      () => LoyaltyPointsController(),
    );
  }
}
