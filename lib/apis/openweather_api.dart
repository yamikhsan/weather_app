import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/forecast.dart';

class OpenWeatherAPI {
  static OpenWeatherAPI instance = Get.find();

  Forecast? forecast;
  String apiKey = dotenv.env['API_KEY'] ?? '';
  String baseUrl = 'api.openweathermap.org';
  String path = 'data/2.5/forecast';

  String iconUrl(String icon) {
    return "https://openweathermap.org/img/wn/$icon@2x.png";
  }

  getForecast({
    double latitude = 44.34,
    double longitude = 10.99,
  }) async {
    log('apiKey: $apiKey');
    log('latitude: $latitude');
    log('longitude: $longitude');

    final queryParams = {
      "lat": "$latitude",
      "lon": "$longitude",
      "appid": apiKey,
      "units": "metric",
    };
    try {
      final url = Uri.https(baseUrl, path, queryParams);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        forecast = Forecast.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      log('OpenWeatherAPI Error: $e');
    }
  }
}
