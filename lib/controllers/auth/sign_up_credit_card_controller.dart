import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:credit_card_type_detector/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:washly/utils/models/w_user.dart';
import 'package:washly/utils/services.dart'; 

import '../../views/screens/auth/start_washing_screen.dart'; 
enum PayementMethod { creditcard, cash }

class SignUpCreditCardController extends GetxController {
  PayementMethod payementMethod = PayementMethod.creditcard;
  TextEditingController cardController = TextEditingController();
  TextEditingController cardHolderController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  bool suffixIconEnabled = false;
  bool isVerified = false;
  bool isVisa = false;
  bool isMasterCard = false;
  RxBool isLoading = false.obs;

  checkCard() {
    var types = detectCCType(cardController.text);
    if (types.contains(CreditCardType.visa())) {
      isVisa = true;
      isMasterCard = false;
    } else if (types.contains(CreditCardType.mastercard())) {
      isMasterCard = true;
      isVisa = false;
    } else {
      isMasterCard = false;
      isVisa = false;
    }
    update();
 
  }

  verify() {
    if (payementMethod == PayementMethod.creditcard) {
      if (cardController.text.isEmpty) {
        isVerified = false;
      } else if (cardHolderController.text.isEmpty) {
        isVerified = false;
      } else if (expiryDateController.text.isEmpty) {
        isVerified = false;
      } else if (cardController.text.length < 19 ||
          expiryDateController.text.length < 5) {
        isVerified = false;
      } else {
        isVerified = true;
      }
    } else {
      isVerified = true;
    }

    update();
  }

  skip() async {
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
          .update({'current_page': "startWashingScreen"}).then((value) async {
        isLoading.toggle();
        update();
        Get.to(() => const StartWashingScreen(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 500));
      });
    });
  }

  Future<void> submit() async {
    if (isVerified) {
      isLoading.toggle();
      update();
      // Get.snackbar('good', 'good message');
      // Get.to(() => SignUpCar());
      WUser user = WUser();
      await getUserFromSession().then((value) async {
        user = value;
        CreditCard creditCard = CreditCard(
          cardNumber: cardController.text,
          cardholder: cardHolderController.text,
          expiryDate: expiryDateController.text,
        );

        await FirebaseFirestore.instance
            .collection('w_users')
            .doc(user.uid)
            .update({
          'credit_card': payementMethod == PayementMethod.creditcard
              ? creditCard.toJson()
              : null,
          'pay_type': payementMethod == PayementMethod.creditcard
              ? 'credit_card'
              : 'cash',
          'current_page': "startWashingScreen"
        }).then((value) async {
          isLoading.toggle();
          update();
          Get.to(() => const StartWashingScreen(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 500));
        });
      });
    } else {
      Get.snackbar('bad', 'bad message');
    }
  }
}
