import 'package:get/get.dart';
import 'package:weather_app/pages/authentication/controllers/otp_controller.dart';

class OTPBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OTPController());
  }
}
