import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:weather_app/apis/openweather_api.dart';
import 'package:weather_app/pages/authentication/controllers/authentication_controller.dart';
import 'package:weather_app/pages/weather_list/controllers/weather_list_controller.dart';
import 'package:weather_app/routes.dart';

class MyAppController extends GetxController {
  String initialRoute = Routes.weatherListPage;

  @override
  void onInit() {
    super.onInit();
    Get.put(OpenWeatherAPI());
    Get.put(AuthenticationController());
    Get.put(WeatherListController());
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        initialRoute = Routes.weatherListPage;
      } else {
        initialRoute = Routes.authenticationPage;
      }
      log("initial route: $initialRoute");
      update();
    });
  }
}
