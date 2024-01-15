import 'package:get/get.dart';
import 'package:washly/controllers/client/main_controller.dart';

enum PayementWay { wallet, creditcard, cash }

class PayController extends GetxController {
  PayementWay payementWay = PayementWay.wallet;
  bool checkBoxValue = false;
  bool allowed = false;
  final contr = Get.put(MainController());
  void verify() {
    if (payementWay == PayementWay.cash) {
      allowed = true;
      update();
    }
    // if (contr.washType != WashType.basic) {
    //   //full, Premium
    //   if ((payementWay == PayementWay.cash ||
    //           payementWay == PayementWay.creditcard) &&
    //       checkBoxValue == true) {
    //     allowed = true;
    //     update();
    //   } else {
    //     allowed = false;
    //     update();
    //   }
    // } else {
    //   if (payementWay == PayementWay.creditcard) {
    //     allowed = true;
    //     update();
    //   }else {
    //     allowed = false;
    //     update();
    //   }
    // }
  }
}
