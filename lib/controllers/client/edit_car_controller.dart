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
import 'package:washly/views/components/widgets.dart';
import 'package:washly/views/screens/client/home_screen.dart';

import '../../utils/services.dart';

class EditCarController extends GetxController {
  Car car = Car();

  @override
  void onInit() {
    car = Get.arguments;
    convertJsonToCar();
    getCars();
    makeController.text = car.make!;
    licencePlateController.text = car.licencePlate!;
    update();
    modelController.text = car.model!;
    update();
    getUserFromSession().then((value) {
      user = value;
      update();
    });

    super.onInit();
  }

  bool isVerified = false;
  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController licencePlateController = TextEditingController();
  List<String> carsMake = [];
  WUser user = WUser();
  List<String> carsModel = [];
  bool suffixIconEnabled = true;
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

    carsModel.addAll(jsonCar
        .where((element) => element.brand == car.make)
        .toList()[0]
        .models!);
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

  submit() async {
    verify();
    if (isVerified) {
      isLoading.toggle();
      update();
 
      if (file != null) {
        await FirebaseStorage.instance
            .ref('users-cars/${file!.name}')
            .putFile(image!)
            .then((p0) {
          p0.ref.getDownloadURL().then((value) async {
            user.cars[user.cars.indexWhere((element) => element.uid == car.uid)] =
                Car(
                    uid: car.uid,
                    make: makeController.text,
                    model: modelController.text,
                    licencePlate: licencePlateController.text,
                    image: value);

            await FirebaseFirestore.instance
                .collection('w_users')
                .doc(user.uid)
                .update(user.toJson());
            isLoading.toggle();
            update();
            final carsListController = Get.put(CarsListController());
            saveToSession(user);
            carsListController.user = user;
            carsListController.carShow = false;
            carsListController.update();
            FocusManager.instance.primaryFocus?.unfocus();
            Get.to(
              () => const HomeScreen(),
              transition: Transition.rightToLeft,
              duration: const Duration(milliseconds: 500),
            );
            carsListController.showScnackbar(
                "Car has been updated Successfully",
                "${makeController.text} has been saved",
                true);
            Get.delete<EditCarController>();
          });
        });
      } else {
        user.cars[user.cars.indexWhere((element) => element.model == car.model)] =
            Car(
                uid: car.uid,
                make: makeController.text,
                model: modelController.text,
                licencePlate: licencePlateController.text,
                image: car.image);
        await FirebaseFirestore.instance
            .collection('w_users')
            .doc(user.uid)
            .update(user.toJson());
        isLoading.toggle();
        update();
        final carsListController = Get.put(CarsListController());
        saveToSession(user);
        carsListController.user = user;

        carsListController.carShow = false;
        carsListController.update();
        FocusManager.instance.primaryFocus?.unfocus();

        Get.to(
          () => const HomeScreen(),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 500),
        );
        carsListController.showScnackbar("Car has been updated Successfully",
            "${makeController.text} has been saved", true);
        Get.delete<EditCarController>();
      }
    }
  }

  deleteCar() {
    deleteCarDialog(
        context: Get.context!,
        title: 'Delete Car ?',
        content:
            'You \'re about to remove ${car.make} ${car.model} , ${car.licencePlate} car',
        onConfirm: () async {
          user.cars.removeWhere((element) => element.uid == car.uid);
          await FirebaseFirestore.instance
              .collection('w_users')
              .doc(user.uid)
              .update(user.toJson());
          saveToSession(user);
          final carsListController = Get.put(CarsListController());
          carsListController.user = user;
          carsListController.carShow = false;
          carsListController.update();
          FocusManager.instance.primaryFocus?.unfocus();
          Get.to(
            () => const HomeScreen(),
            transition: Transition.rightToLeft,
            duration: const Duration(milliseconds: 500),
          );
          carsListController.showScnackbar("Car deleted",
              "${makeController.text}  car has been removed", true);
          Get.delete<EditCarController>();
        });
  }

  void removeImage() {
    image = null;
    file = null;
    verify();
    update();
  }
}
