import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weather_app/routes.dart';

enum AuthState { login, register }

enum AuthMethod { email, phone }

class AuthenticationController extends GetxController {
  static AuthenticationController instance = Get.find();

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final String phone = "Phone";
  final String email = "Email";
  final String login = "Login";
  final String register = "Register";
  final String signIn = "Sign In";
  final String signUp = "Sign Up";

  AuthState authState = AuthState.login;
  AuthMethod authMethod = AuthMethod.email;

  final RxString _authStateText = "".obs;
  final RxString _authMethodButton = "".obs;
  final RxString _authStateButton = "".obs;

  String get authStateText => _authStateText.value;
  String get authMethodButton => _authMethodButton.value;
  String get authStateButton => _authStateButton.value;

  FirebaseAuth auth = FirebaseAuth.instance;

  bool progress = false;

  @override
  void onInit() {
    super.onInit();
    _authStateText.value = login;
    _authMethodButton.value = phone;
    _authStateButton.value = signUp;
  }

  changeAuthState() {
    if (!progress) {
      if (authState == AuthState.login) {
        authState = AuthState.register;
        _authStateText.value = register;
        _authStateButton.value = signIn;

        authMethod = AuthMethod.email;
        _authMethodButton.value = phone;
      } else {
        authState = AuthState.login;
        _authStateText.value = login;
        _authStateButton.value = signUp;
      }

      cleanTextController();
      update();
    }
  }

  changeAuthMethod() {
    if (!progress) {
      if (authMethod == AuthMethod.email) {
        authMethod = AuthMethod.phone;
        _authMethodButton.value = email;

        authState = AuthState.login;
        _authStateText.value = login;
        _authStateButton.value = signUp;
      } else {
        authMethod = AuthMethod.email;
        _authMethodButton.value = phone;
      }

      cleanTextController();
      update();
    }
  }

  onPressedEmail() async {
    if (formKey.currentState!.validate() && !progress) {
      log('validation email success');
      if (authState == AuthState.register) {
        try {
          openSnackBar(message: "Sign up...");
          await auth.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
          closeSnackBar();
          cleanTextController();
        } on FirebaseAuthException catch (e) {
          catchMessage(e.message ?? 'unknown');
        } catch (e) {
          log('$e');
        }
      } else {
        try {
          openSnackBar();
          await auth.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
          closeSnackBar();
          cleanTextController();
        } on FirebaseAuthException catch (e) {
          catchMessage(e.message ?? 'unknown');
        } catch (e) {
          log('$e');
        }
      }
    }
  }

  onPressedPhone() async {
    if (formKey.currentState!.validate() && !progress) {
      log('validation phone success');
      String phone = phoneController.text;
      if (phone.startsWith('0')) {
        phone = phone.replaceFirst('0', '+62');
      }
      log('phone: $phone');
      await auth.verifyPhoneNumber(
        phoneNumber: phone,
        // timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!
          openSnackBar();
          await auth.signInWithCredential(credential);
          closeSnackBar();
          cleanTextController();
        },
        verificationFailed: (FirebaseAuthException e) {
          catchMessage(e.message ?? 'unknown');
        },
        codeSent: (String verificationId, int? resendToken) async {
          String smsCode = await toOTP();

          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          );

          openSnackBar();
          await auth.signInWithCredential(credential);
          closeSnackBar();
          cleanTextController();
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  onPressedGoogle() async {
    if (!progress) {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      openSnackBar();

      await auth.signInWithCredential(credential);

      cleanTextController();
      closeSnackBar();
    }
  }

  openSnackBar({String message = "Sign in..."}) {
    progress = true;
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        showProgressIndicator: true,
      ),
    );
  }

  closeSnackBar() {
    progress = false;
    Get.closeCurrentSnackbar();
  }

  catchMessage(String message) {
    closeSnackBar();
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<String> toOTP() async {
    final code = await Get.toNamed(Routes.otpPage);
    if (code != null) return code;
    return "";
  }

  signOut() async {
    await auth.signOut();
  }

  cleanTextController() {
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
  }
}
