import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:weather_app/pages/authentication/controllers/authentication_controller.dart';
import 'package:weather_app/pages/weather_list/controllers/weather_list_controller.dart';
import 'package:weather_app/pages/weather_list/views/widgets/forecast_item.dart';

class WeatherListPage extends GetView<WeatherListController> {
  const WeatherListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Weather App"),
          actions: [
            GestureDetector(
              onTap: () => AuthenticationController.instance.signOut(),
              child: const Icon(Icons.exit_to_app),
            ),
            const Gap(20),
          ],
        ),
        body: GetBuilder<WeatherListController>(
          builder: (_) {
            return controller.weathers.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    color: Colors.white,
                    backgroundColor: Colors.blue,
                    strokeWidth: 4.0,
                    onRefresh: () async => await controller.getForecast(),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.weathers.length,
                      separatorBuilder: (context, index) => const Divider(
                        thickness: 1.0,
                      ),
                      itemBuilder: (context, index) {
                        return WeatherItem(
                          controller: controller,
                          index: index,
                        );
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}
