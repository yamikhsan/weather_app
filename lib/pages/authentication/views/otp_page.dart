import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:weather_app/pages/authentication/controllers/otp_controller.dart';

class OTPPage extends GetView<OTPController> {
  const OTPPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Input OTP",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Gap(40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: Get.width / 10,
              style: const TextStyle(fontSize: 16),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) => controller.onCompleted(pin),
              onChanged: (text) {},
            ),
          ),
        ],
      ),
    );
  }
}
