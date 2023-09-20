import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    } else { 
    }
  }

  void showDialog(BuildContext context) {
    showBottomDialog(
      context: context,
      allowBackNavigation: true,
    );
  }

  @override
  void onInit() {
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
