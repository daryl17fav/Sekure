import 'package:get/get.dart';

import '../../modules/my_orders/controllers/my_orders_controller.dart';

class MyOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyOrdersController>(
      () => MyOrdersController(),
    );
  }
}
