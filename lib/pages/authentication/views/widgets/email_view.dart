import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:weather_app/pages/authentication/controllers/authentication_controller.dart';
import 'package:weather_app/pages/authentication/views/widgets/custom_elevated_button.dart';

class EmailView extends StatelessWidget {
  const EmailView({
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
            controller: controller.emailController,
            decoration: const InputDecoration(hintText: "Email"),
            keyboardType: TextInputType.emailAddress,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }

              final RegExp emailRegExp = RegExp(
                r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
              );
              if (!emailRegExp.hasMatch(value)) {
                return 'Invalid email format';
              }
              return null;
            },
          ),
          const Gap(20),
          TextFormField(
            controller: controller.passwordController,
            obscureText: true,
            decoration: const InputDecoration(hintText: "Password"),
            keyboardType: TextInputType.text,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const Gap(20),
          Obx(
            () => CustomElevatedButton(
              text: controller.authStateText.toUpperCase(),
              onPressed: () => controller.onPressedEmail(),
            ),
          ),
        ],
      ),
    );
  }
}
