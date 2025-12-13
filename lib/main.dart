import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/services/service_initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize all services
  await ServiceInitializer.init();
  
  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.LOGIN,
      getPages: AppPages.routes,
    ),
  );
}
