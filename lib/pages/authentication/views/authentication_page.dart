import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:weather_app/pages/authentication/controllers/authentication_controller.dart';
import 'package:weather_app/pages/authentication/views/widgets/custom_outline_button.dart';
import 'package:weather_app/pages/authentication/views/widgets/email_view.dart';
import 'package:weather_app/pages/authentication/views/widgets/phone_view.dart';

class AuthenticationPage extends GetView<AuthenticationController> {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(40),
              Obx(
                () => Text(
                  controller.authStateText,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              const Gap(40),
              GetBuilder<AuthenticationController>(
                builder: (_) {
                  return controller.authMethod == AuthMethod.email
                      ? EmailView(controller: controller)
                      : PhoneView(controller: controller);
                },
              ),
              const Gap(20),
              Row(
                children: [
                  const Expanded(child: Divider(thickness: 2.0)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('OR',
                        style: Theme.of(context).textTheme.labelLarge),
                  ),
                  const Expanded(child: Divider(thickness: 2.0)),
                ],
              ),
              const Gap(20),
              Obx(
                () => CustomOutlineButton(
                  onPressed: () => controller.changeAuthMethod(),
                  text: "Login with ${controller.authMethodButton}",
                ),
              ),
              const Gap(20),
              CustomOutlineButton(
                onPressed: () => controller.onPressedGoogle(),
                text: "Login with Google",
              ),
              const Gap(20),
              Obx(
                () => Text.rich(
                  TextSpan(
                    text: 'Don\'t have an account? ',
                    style: const TextStyle(fontSize: 16, color: Colors.black45),
                    children: [
                      TextSpan(
                        text: controller.authStateButton,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => controller.changeAuthState(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
