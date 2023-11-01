import 'package:get/get.dart';

enum PayementWay { wallet, creditcard, cash }

class PayController extends GetxController {
  PayementWay payementWay = PayementWay.wallet;
  bool checkBoxValue = true;
  bool allowed = false;
  void verify() {
    if (payementWay == PayementWay.wallet) {
      allowed = false;
    } else {
      allowed = true;
    }
    update();
  }
}
