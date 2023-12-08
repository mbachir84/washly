import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washly/controllers/client/appoitment_controller.dart';
import 'package:washly/controllers/client/checkout_controller.dart';
import 'package:washly/controllers/client/choose_car_controller.dart';
import 'package:washly/utils/models/w_user.dart';
import 'package:washly/utils/services.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:washly/views/components/widgets.dart';

enum WashType { basic, full, premium }

class MainController extends GetxController {
  WashType washType = WashType.basic;
  WUser user = WUser();
  RxBool isLoading = false.obs;
  String address = "";
  getUserLocation() async {
    if (user.addresses!.isNotEmpty) {
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
          user.addresses![0].latitude!, user.addresses![0].longitude!,
          localeIdentifier: "fr_FR");
      address = placemarks.first.thoroughfare!;
      for (int i = 0; i < placemarks.length; i++) {
        if (placemarks[i].thoroughfare != "") {
          address = placemarks[i].thoroughfare!;
          break;
        }
      }
      update();
    } else {}
  }

  addToAppointment() {
    final appoitmentController = Get.put(AppointementController());
    final chooseCar = Get.put(ChooseCarController());
    appoitmentController.appointment.washType = typeWash();
    appoitmentController.appointment.customerName = user.fullname;
    final checkoutController = Get.put(CheckoutController());
    appoitmentController.appointment.appointmentDateTime =
        checkoutController.hourSelected;
    appoitmentController.appointment.contactInformation = user.phoneNumber;
    appoitmentController.appointment.carDetails = chooseCar.selectedCar.make;
  }

  String typeWash() {
    switch (washType) {
      case WashType.basic:
        return "Basic wash";
      case WashType.full:
        return "Full wash";
      case WashType.premium:
        return "Premium wash";
      default:
        return "Unknown wash";

      // Provide a default value
    }
    
  }

  String priceWash() {
    switch (washType) {
      case WashType.basic:
        return "20";
      case WashType.full:
        return "40";
      case WashType.premium:
        return "40";
      default:
        return "Unknown wash"; // Provide a default value
    }
  }

  void showDialog(BuildContext context) {
    showBottomDialog(
      context: context,
      allowBackNavigation: true,
    );
  }

  // void isCarSelected() {
  //   user.cars.map((e) => e.isSelected! ? e.make : null);
  // }

  @override
  void onInit() {
    // updateCarsDocument();
    handlerPermission();
    isLoading.toggle();
    update();
    getUserFromSession().then((value) {
      user = value;
      getUserFromDb(value.uid).then((value) {
        user = value;
        getUserLocation();
        isLoading.toggle();
        update();
      });
    });
    // TODO: implement onInit
    super.onInit();
  }
}
