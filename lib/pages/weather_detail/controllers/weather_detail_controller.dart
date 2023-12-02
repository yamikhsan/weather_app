import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/apis/openweather_api.dart';
import 'package:weather_app/models/forecast.dart';

class WeatherDetailController extends GetxController {
  final args = Get.arguments;
  OpenWeatherAPI openWeatherAPI = OpenWeatherAPI.instance;
  ListElement? weather;

  @override
  void onInit() {
    super.onInit();
    weather = openWeatherAPI.forecast!.list[args];
    update();
  }

  String weatherDate() {
    if (weather != null) {
      final dateTime = DateFormat('EEEE, MMMM dd, yyyy').format(weather!.dtTxt);
      return dateTime;
    }
    return '';
  }

  String weatherTime() {
    if (weather != null) {
      final dateTime = DateFormat('hh:mm a').format(weather!.dtTxt);
      return dateTime;
    }
    return '';
  }

  String weatherIcon() {
    if (weather != null) {
      final iconUrl = openWeatherAPI.iconUrl(weather!.weather.first.icon);
      return iconUrl;
    }
    return "";
  }

  String weatherDesc() {
    if (weather != null) {
      final desc =
          "${weather!.weather.first.main}(${weather!.weather.first.description})";
      return desc;
    }
    return "";
  }
}
