import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';

class SplashController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    _checkAuthAndNavigate();
  }

  void _checkAuthAndNavigate() async {
    // Wait a moment for splash effect and any service initialization
    await Future.delayed(const Duration(seconds: 2));

    if (_authService.isAuthenticated.value) {
      // User is authenticated, try to restore last route
      try {
        final prefs = await SharedPreferences.getInstance();
        final lastRoute = prefs.getString('last_route');

        if (lastRoute != null && lastRoute.isNotEmpty) {
           Get.offNamed(lastRoute);
        } else {
           Get.offNamed(Routes.HOME);
        }
      } catch (e) {
        // Fallback to home on error
        Get.offNamed(Routes.HOME);
      }
    } else {
      // Not authenticated
      Get.offNamed(Routes.LOGIN);
    }
  }

  void skipToLogin() {
    _checkAuthAndNavigate();
  }
}
