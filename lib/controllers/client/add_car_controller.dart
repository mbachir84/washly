import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:washly/controllers/client/cars_list_controller.dart';
import 'package:washly/utils/constants.dart';
import 'package:washly/utils/models/jsonCar.dart';
import 'package:washly/utils/models/w_user.dart';
import 'package:washly/utils/services.dart';

class AddCarController extends GetxController {
  bool isVerified = false;
  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController licencePlateController = TextEditingController();
  List<String> carsMake = [];
  WUser user = WUser();
  List<String> carsModel = [];
  bool suffixIconEnabled = false;
  RxBool isLoading = false.obs;
  List<JsonCar> jsonCar = [];
  XFile? file;
  File? image;

  selectImage() async {
    try {
      file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file != null) {
        image = File(file!.path);
        update();
      }
    } catch (e) {}
    verify();
  }

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
    user = Get.arguments.first;
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
    } else if (file == null || image == null) {
      isVerified = false;
    } else {
      isVerified = true;
    }
    update();
  }

  submit() async {
    verify();
    if (isVerified) {
      isLoading.toggle();
      update();
      await FirebaseStorage.instance
          .ref('users-cars/${file!.name}')
          .putFile(image!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) async {
          user.cars.add(Car(
              uid: generateRandomString(20),
              make: makeController.text,
              model: modelController.text,
              licencePlate: licencePlateController.text,
              image: value));
          await FirebaseFirestore.instance
              .collection('w_users')
              .doc(user.uid)
              .update(user.toJson());
          isLoading.toggle();
          update();
          final carsListController = Get.put(CarsListController());
          saveToSession(user);
          carsListController.user = user;
          carsListController.showScnackbar("Car Added Successfully",
              "${makeController.text} has been saved", true);
          carsListController.update();
          FocusManager.instance.primaryFocus?.unfocus();
          Get.delete<AddCarController>();
          Get.back();
        });
      });
    }
  }

  void removeImage() {
    image = null;
    file = null;
    verify();
    update();
  }
}
