import 'package:get/get.dart';

import '../../modules/buyer_orders_list/controllers/buyer_orders_list_controller.dart';

class BuyerOrdersListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyerOrdersListController>(
      () => BuyerOrdersListController(),
    );
  }
}
