import 'package:easy_localization/easy_localization.dart';
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
  bool isToday = false;
  String dateFormat = "";
  int counter = 0;
  String hourSelected = "";
  DateTime currentTime = DateTime.now();
  DateTime dateValue = DateTime.now();

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

  selectHour() {
    if (counter == 0) {
      hourSelected = "Wash now";
      //change to wash now
      // if ((currentTime.minute + 15) >= 60) {
      //   if (((currentTime.minute + 15) - 60) < 10) {
      //     hourSelected =
      //         "${(currentTime.hour).toString()} :0${((currentTime.minute + 15) - 60).toString()} -${(currentTime.hour+1).toString()}:${((currentTime.minute + 15) - 60).toString()}";
      //   } else {
      //     hourSelected =
      //         "${currentTime.hour.toString()}:${((currentTime.minute + 15)-60).toString()} -${(currentTime.hour + 1).toString()}:${((currentTime.minute + 15)-60).toString()} ";
      //   }
      // } else {
      //   hourSelected =
      //       "${currentTime.hour.toString()}:${(currentTime.minute + 15).toString()} -${(currentTime.hour + 1).toString()}:${(currentTime.minute + 15).toString()} ";
      //   print("mouad $hourSelected");
      // }
    } else {
      for (int i = 1; i < 14; i++) {
        if (counter == i) {
          hourSelected = "${07 + i}:00 - ${08 + i}:00";
          print("mouad $hourSelected");
        }
      }
    }
  }

  getHourSelected() async {
    // for (int i = 1; i < 15; i++) {
    if (isToday) {
      await selectHour();
    } else {
      if (counter == 0) {
        //dateFormat == curentime
        if ((currentTime.minute + 15) >= 60) {
          if (((currentTime.minute + 15) - 60) < 10) {
            hourSelected = "";
          } else {
            hourSelected = " ";
          }
        } else {
          hourSelected = " ";
          print("mouad $hourSelected");
        }
      } else {
        for (int i = 1; i < 14; i++) {
          if (counter == i) {
            hourSelected = "${07 + i}:00 - ${08 + i}:00";
            print("mouad $hourSelected");
          }
        }
      }
    }
    // }
  }

  @override
  void onInit() {
    selectHour();

    dateFormat = DateFormat.yMMMMd().format(currentTime);
    // TODO: implement onInit
    super.onInit();
  }
}
