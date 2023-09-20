import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:washly/views/screens/auth/sign_up_credit_card.dart';

import '../../utils/constants.dart';
import '../../utils/models/jsonCar.dart';
import '../../utils/models/w_user.dart';
import '../../utils/services.dart';

class SignUpCarController extends GetxController {
  bool isVerified = false;
  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController licencePlateController = TextEditingController();
  List<String> carsMake = [];
  List<String> carsModel = [];
  RxBool isLoading = false.obs;
  List<JsonCar> jsonCar = [];

  getCars() {
    carsMake.clear();
    carsModel.clear();
    for (var element in jsonCar) {
      carsMake.add(element.brand!);
    }

    carsModel.addAll(jsonCar[0].models!);
  }

  updateCars() {
    carsModel.clear();
    update();
    int count = 0;
    for (var element in jsonCar) {
      if (element.brand == makeController.text) {
        carsModel.addAll(jsonCar[count].models!);
      }
      count++;
    }
    update();
  }

  convertJsonToCar() {
    for (var element in jsonCars) {
      jsonCar.add(JsonCar.fromJson(element));
    }
  }

  @override
  void onInit() {
    convertJsonToCar();
    getCars();
    super.onInit();
  }

  void verify() {
    if (makeController.text.isEmpty) {
      isVerified = false;
    } else if (modelController.text.isEmpty) {
      isVerified = false;
    } else if (licencePlateController.text.isEmpty) {
      isVerified = false;
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
          .update({'current_page': "signUpCreditCard"}).then((value) async {
        isLoading.toggle();
        update();
        Get.to(() => const SignUpCreditCard(),
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
        Car car = Car(
            make: makeController.text,
            model: modelController.text,  
            image:
                "https://firebasestorage.googleapis.com/v0/b/washly-b8ab4.appspot.com/o/user-images%2Fno-car-icon.png?alt=media&token=93afe7f5-d697-42d5-93c8-53c6e97a7a3f",
            licencePlate: licencePlateController.text);
        List<Car> list = [];
        list.add(car);

        await FirebaseFirestore.instance
            .collection('w_users')
            .doc(user.uid)
            .update({
          'cars': list.map((e) => e.toJson()).toList(),
          'current_page': "signUpCreditCard"
        }).then((value) async {
          isLoading.toggle();
          update();
          Get.to(() => const SignUpCreditCard(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 500));
        });
      });
    }
  }
}
