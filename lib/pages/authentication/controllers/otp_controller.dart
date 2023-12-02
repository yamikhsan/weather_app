import 'dart:developer';

import 'package:get/get.dart';

class OTPController extends GetxController {
  onCompleted(String pin) {
    log("Completed: $pin");
    Get.back(result: pin);
  }
}
