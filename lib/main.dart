import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/services/service_initializer.dart';

import 'app/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize all services
  await ServiceInitializer.init();


  // ignore: unused_local_variable
  final authService = Get.find<AuthService>();

  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.SPLASH,
      getPages: AppPages.routes,
      routingCallback: (routing) async {
        if (routing != null && routing.current.isNotEmpty) {
          // Don't save splash or login as restore points
          if (routing.current != Routes.SPLASH && 
              routing.current != Routes.LOGIN &&
              routing.current != Routes.ROLE_SELECTION) {
             
             try {
               final prefs = await SharedPreferences.getInstance();
               await prefs.setString('last_route', routing.current);
             } catch (e) {
               // Ignore storage errors during nav
             }
          }
        }
      },
    ),
  );
}
