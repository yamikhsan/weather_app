import 'package:get/get.dart';
import 'package:weather_app/pages/weather_detail/controllers/weather_detail_controller.dart';

class WeatherDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WeatherDetailController());
  }
}
