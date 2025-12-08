import 'package:get/get.dart';

import '../controllers/buyer_orders_list_controller.dart';

class BuyerOrdersListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyerOrdersListController>(
      () => BuyerOrdersListController(),
    );
  }
}
