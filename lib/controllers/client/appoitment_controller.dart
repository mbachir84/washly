import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washly/controllers/client/home_controller.dart';
import 'package:washly/controllers/client/main_controller.dart';
import 'package:washly/utils/models/appointment.dart';
import 'package:washly/utils/models/w_user.dart';
import 'package:washly/utils/services.dart';
import 'package:washly/views/screens/client/home_screen.dart';

import '../../views/components/widgets.dart';

class AppointementController extends GetxController {
  bool loading = false;
  WUser user = WUser();
  RxBool isLoading = false.obs;
  bool appointmentShow = false;
  double height = 0;
  String snackBarTitle = "";
  String snackBarSubTitle = "";
  bool paid = false;
  bool state = false;
  List<Appointment> appoitmentList = [];
  List<String> appoitment_Id = [];
  int myIndex = 0;
  // final mainController = Get.put(MainController());
  // String typeWash ="";
  // wash =  mainController.typeWash();
  infoClick() {
    showDetailDialog(context: Get.context!, allowBackNavigation: true);
  }

  showScnackbar(text, subtext, status) {
    height = 137;
    snackBarTitle = text;
    snackBarSubTitle = subtext;
    state = status;
    update();
    Future.delayed(const Duration(seconds: 4), () {
      height = 0;
      update();
    });
  }

  Appointment appointment = Appointment(
      status: "scheduled",
      paymentInformation: "Credit Card");

  submit() async {
    await FirebaseFirestore.instance
        .collection("appointment")
        .add(appointment.toJson());
  }

  getAppoitment() async {
    appoitmentList.clear();
    await FirebaseFirestore.instance
        .collection('appointment')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc["uid"] == user.uid) {
          Appointment appointment =
              Appointment.fromJson(doc.data()! as Map<String, dynamic>);
          appoitmentList.add(appointment);
        }
      }
    });
    
  }

  confirm() async {
    showPayementStatusDialog(
        context: Get.context!, allowBackNavigation: true, status: true);
    await submit();
    Timer(const Duration(milliseconds: 300), () async {
      await getAppoitment();
      Get.back();
      final cont = Get.put(HomeController());
      cont.changeScreen(2);
      Get.off(
        () => const HomeScreen(),
        transition: Transition.rightToLeft,
        duration: 500.milliseconds,
      );
      cont.update();

      Get.snackbar("Success", "Appointement Added",
          backgroundColor: Colors.green);
    });
  }

  @override
  void onInit() async {
    isLoading.toggle();
    update();
    await getUserFromSession().then((value) async {
      user = value;
      await getAppoitment();
      isLoading.toggle();
      update();
    });

    super.onInit();
  }
}
