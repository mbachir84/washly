import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:washly/views/screens/auth/verify_code_screen.dart';

class VerifyPhoneController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  bool allowed = false;
  RxBool loading = false.obs;
  verifyPhone() {
    if (phoneController.text.isNotEmpty && phoneController.text.length == 9) {
      allowed = true;
      update();
    } else {
      allowed = false;
      update();
    }
  }

  submit() async {
    if (allowed) {
      loading.toggle();
      update();
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+212${phoneController.text}",
        verificationCompleted: (phonesAuthCredentials) async {
          //Get.to(HomeScreen);
          print("verification completed executed");
          // loading.toggle();
        },
        verificationFailed: (FirebaseAuthException e) async {
          print("failed o  $e");
          loading.toggle();
          update();
        },
        codeSent: (verificationId, resendingToken) async {
          print("codeSent $verificationId");

          await SessionManager()
              .set('phone', "+212${phoneController.text}")
              .then((value) {
            loading.toggle();
            update();
            Get.to(() => const VerifyCodeScreen(),
                arguments: verificationId,
                transition: Transition.fadeIn,
                duration: const Duration(milliseconds: 500));
          });
        },
        codeAutoRetrievalTimeout: (verificationId) async {},
      );
    }
  }
}
