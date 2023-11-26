import 'package:get/get.dart';

enum PayementWay { wallet, creditcard, cash }

class PayController extends GetxController {
  PayementWay payementWay = PayementWay.wallet;
  bool checkBoxValue = false;
  bool allowed = false;
  void verify() {
    if (payementWay == PayementWay.cash && checkBoxValue == true) {
      allowed = true;
    } else {
      allowed = false;
    }
    update();
  }
}
