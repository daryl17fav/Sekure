import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';
import '../../../../widgets/common_widgets.dart'; 

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return SekureBackground(
      child: Center(
        child: SekureLogo(size: 50),
      ),
    );
  }
}