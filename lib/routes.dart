import 'package:get/get.dart';
import 'package:weather_app/pages/authentication/bindings/otp_binding.dart';
import 'package:weather_app/pages/authentication/views/authentication_page.dart';
import 'package:weather_app/pages/authentication/views/otp_page.dart';
import 'package:weather_app/pages/weather_detail/bindings/weather_detail_binding.dart';
import 'package:weather_app/pages/weather_detail/views/weather_detail_page.dart';
import 'package:weather_app/pages/weather_list/views/weather_list_page.dart';

class Routes {
  Routes._();

  static const String authenticationPage = '/authenticationPage';
  static const String weatherListPage = '/weatherListPage';
  static const String weatherDetailPage = '/weatherDetailPage';
  static const String otpPage = '/otpPage';

  static final pages = [
    GetPage(
      name: authenticationPage,
      page: () => const AuthenticationPage(),
    ),
    GetPage(
      name: weatherListPage,
      page: () => const WeatherListPage(),
    ),
    GetPage(
      name: weatherDetailPage,
      page: () => const WeatherDetailPage(),
      binding: WeatherDetailBinding(),
    ),
    GetPage(
      name: otpPage,
      page: () => const OTPPage(),
      binding: OTPBinding(),
    ),
  ];
}
