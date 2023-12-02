import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:weather_app/pages/authentication/controllers/authentication_controller.dart';
import 'package:weather_app/pages/authentication/views/widgets/custom_elevated_button.dart';

class PhoneView extends StatelessWidget {
  const PhoneView({
    super.key,
    required this.controller,
  });

  final AuthenticationController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: controller.phoneController,
            decoration: const InputDecoration(hintText: "Phone"),
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }

              final RegExp phoneRegExp = RegExp(
                r'^0\d{8,14}$',
              );
              if (!phoneRegExp.hasMatch(value)) {
                return 'Invalid phone number format';
              }
              return null;
            },
          ),
          const Gap(20),
          Obx(
            () => CustomElevatedButton(
              text: controller.authStateText.toUpperCase(),
              onPressed: () => controller.onPressedPhone(),
            ),
          ),
        ],
      ),
    );
  }
}
