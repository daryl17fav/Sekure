import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';
import '../../../../widgets/common_widgets.dart'; 

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        // Detect swipe left or right
        if (details.primaryVelocity != null && details.primaryVelocity!.abs() > 500) {
          controller.skipToLogin();
        }
      },
      onVerticalDragEnd: (details) {
        // Detect swipe up
        if (details.primaryVelocity != null && details.primaryVelocity! < -500) {
          controller.skipToLogin();
        }
      },
      child: SekureBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SekureLogo(size: 50),
              const SizedBox(height: 40),
              const Text(
                'Swipe to continue',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const Icon(
                Icons.swipe,
                color: Colors.black54,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}