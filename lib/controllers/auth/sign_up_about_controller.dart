import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washly/views/screens/auth/sign_up_car.dart';

import '../../utils/models/w_user.dart';
import '../../utils/services.dart';

class SignUpAboutController extends GetxController {
  bool isVerified = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  RxBool isLoading = false.obs;

  verify() {
    if (emailController.text.isEmpty) {
      isVerified = false;
    } else if (fullNameController.text.isEmpty) {
      isVerified = false;
    } else if (fullNameController.text.length < 3) {
      isVerified = false;
    } else if (!GetUtils.isEmail(emailController.text.trim().toLowerCase())) {
      isVerified = false;
    } else {
      isVerified = true;
    }

    update();
  }

  submit() async {
    if (isVerified) {
      isLoading.toggle();
      update();
      // Get.snackbar('good', 'good message');
      // Get.to(() => SignUpCar());
      WUser user = WUser();
      await getUserFromSession().then((value) async {
        user = value;
        await FirebaseFirestore.instance
            .collection('w_users')
            .doc(user.uid)
            .update({
          'fullname': fullNameController.text,
          'email': emailController.text.trim().toLowerCase(),
          'current_page': "signUpCar"
        }).then((value) async {
          isLoading.toggle();
          update();
          Get.to(() => const SignUpCar(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 500));
        });
      });
    } else {}
  }

  skip() async {
    isLoading.toggle();
    update();
    WUser user = WUser();
    await getUserFromSession().then((value) async {
      user = value;
      await FirebaseFirestore.instance
          .collection('w_users')
          .doc(user.uid)
          .update({'current_page': "signUpCar"}).then((value) async {
        isLoading.toggle();
        update();
        Get.to(() => const SignUpCar(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 500));
      });
    });
  }
}
