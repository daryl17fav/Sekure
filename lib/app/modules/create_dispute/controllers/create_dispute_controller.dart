import 'package:get/get.dart';
import '../../../services/disputes_service.dart';


class CreateDisputeController extends GetxController {
  final DisputesService _disputesService = Get.find<DisputesService>();
  
  //TODO: Implement CreateDisputeController

  final count = 0.obs;



  void increment() => count.value++;
}
