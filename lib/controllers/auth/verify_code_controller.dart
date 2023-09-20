import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:washly/utils/models/w_user.dart';
import 'package:washly/views/screens/auth/sign_up_location.dart';

import '../../utils/services.dart';

class VerifyCodeController extends GetxController {
  bool allowed = false;
  double height = 0;
  String snackBarTitle = "";
  String snackBarSubTitle = "";
  bool state = false;
  String verificationCode = "";
  TextEditingController pinController = TextEditingController();
  RxBool loading = false.obs;
  String phoneNumber = "";

  showSnackBar(title, subTitle, stateGiven) {
    snackBarTitle = title;
    snackBarSubTitle = subTitle;
    state = stateGiven;
    height = 137.h;
    update();
    Timer(const Duration(seconds: 4), () {
      height = 0;
      update();
    });
  }

  reverify() async {
    loading.toggle();
    update();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phonesAuthCredentials) async {},
      verificationFailed: (FirebaseAuthException e) async {
        loading.toggle();
        update();
        Get.snackbar('error', e.message!);
      },
      codeSent: (verificationId, resendingToken) async {
        verificationCode = verificationId;
        loading.toggle();
        update();
        showSnackBar("We just resent the code to:", phoneNumber, true);
      },
      codeAutoRetrievalTimeout: (verificationId) async {
        showSnackBar(
            "Error", "Code auto retrieval timeout, please try again", false);
      },
    );
  }

  submit() async {
    if (allowed) {
      loading.toggle();
      update();
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationCode,
            smsCode: pinController.text.trim());
        UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = authResult.user;
        checkPhoneNumber(user!.uid).then((value) async {
          if (value == "found-in-users") {
            await getUserFromDb(user.uid).then((value) async {
              await saveToSession(value);
              initWidget().then((value) => Get.offAll(() => value,
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 500)));
            });
          } else {
            WUser snUser = WUser(
                uid: user.uid,
                phoneNumber: user.phoneNumber,
                fullname: "",
                createdAt: DateTime.now().toString(),
                isDeleted: false,
                currentPage: "signUpLocation",
                isActivated: true,
                isVerified: true,
                isWasher: false);
            await saveUserToDb(snUser).then((value) async {
              await saveToSession(snUser);

              Get.offAll(() => const SignUpLocation(),
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 500));
            });
          }
        });
        loading.toggle();
        update();
      } catch (e) {
        loading.toggle();
        update();
        showSnackBar("Error", e.toString(), false);
      }
    }
  }

  @override
  Future<void> onInit() async {
    await SessionManager().get('phone').then((value) async {
      phoneNumber = value;
      update();
      verificationCode = Get.arguments;
      // try {
      //   await AltSmsAutofill().listenForSms.then((value) {
      //     pinController.text.isEmpty
      //         ? pinController.text =
      //             value!.replaceAll(RegExp(r'[^0-9]'), '').substring(0, 6)
      //         : null;

      //     update();
      //   });
      // } catch (e) {
      //   rethrow;
      // }
    });

    super.onInit();
  }
}
