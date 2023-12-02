import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/pages/app/controllers/myapp_controller.dart';
import 'package:weather_app/pages/authentication/views/authentication_page.dart';
import 'package:weather_app/pages/weather_list/views/weather_list_page.dart';
import 'package:weather_app/routes.dart';

class MyApp extends GetView<MyAppController> {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            gapPadding: 0,
          ),
        ),
        textTheme: const TextTheme(
          labelMedium: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      getPages: Routes.pages,
      home: GetBuilder<MyAppController>(
        builder: (_) {
          return controller.initialRoute == Routes.authenticationPage
              ? const AuthenticationPage()
              : const WeatherListPage();
        },
      ),
    );
  }
}
