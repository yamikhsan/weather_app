import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/apis/openweather_api.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/routes.dart';

class WeatherListController extends GetxController {
  OpenWeatherAPI openWeatherAPI = OpenWeatherAPI.instance;
  List<ListElement> weathers = [];

  @override
  void onInit() async {
    super.onInit();
    getForecast();
  }

  getForecast() async {
    try {
      Position position = await determinePosition();
      await openWeatherAPI.getForecast(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      await openWeatherAPI.getForecast();
      log('$e');
    }
    weathers = openWeatherAPI.forecast?.list ?? [];
    log('weather len: ${weathers.length}');
    update();
  }

  String weatherDate(int index) {
    final dateTime =
        DateFormat('EEEE, dd MMM yyyy hh:mm a').format(weathers[index].dtTxt);
    return dateTime;
  }

  String weatherIcon(int index) {
    final iconUrl = openWeatherAPI.iconUrl(weathers[index].weather.first.icon);
    return iconUrl;
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  toWeatherDetail(int index) {
    Get.toNamed(Routes.weatherDetailPage, arguments: index);
  }
}
