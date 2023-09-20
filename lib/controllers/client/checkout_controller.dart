import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washly/views/components/widgets.dart';

class CheckoutController extends GetxController {
  TextEditingController couponController = TextEditingController();
  double height = 0;
  String snackBarTitle = "";
  String snackBarSubTitle = "";
  String buttonText = "Apply";
  bool state = false;
  void apply() {
    if (couponController.text.isNotEmpty) {
      height = 137;
      snackBarTitle = "Discount code applied";
      snackBarSubTitle = "You got 5% Off!";
      state = true;
      buttonText = "Applied";
      update();
      Future.delayed(const Duration(seconds: 4), () {
        height = 0;
        update();
      });
    } else {
      height = 137;
      snackBarTitle = "Error";
      snackBarSubTitle = "Please enter a valid coupon";
      state = false;
      update();
      Future.delayed(const Duration(seconds: 4), () {
        height = 0;
        update();
      });
    }
  }

  infoClick() {
    showDetailDialog(context: Get.context!, allowBackNavigation: true);
  }
}
