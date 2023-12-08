import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:washly/utils/models/w_user.dart';
import 'package:washly/views/screens/client/appointment_screen.dart';
import 'package:washly/views/screens/client/cars_list_screen.dart';
import 'package:washly/views/screens/client/main_screen.dart';
import 'package:washly/views/screens/client/profile_screen.dart';

import '../../utils/services.dart';

class HomeController extends GetxController {
  // double height = 0;
  // String snackBarTitle = "";
  // String snackBarSubTitle = "";
  bool state = false;
  List<Widget> screens = [
    const MainScreen(),
    const CarsListScreen(),
    const AppointmentScreen(),
    const ProfileScreen()
  ];
  RxBool isLoading = false.obs;
  int currentIndex = 0;
  Widget currentScreen = const MainScreen();

  void changeScreen(int index) {
    currentScreen = screens[index];
    currentIndex = index;
    update();
  }
  // showScnackbar(text, subtext, status) {
  //   height = 137;
  //   snackBarTitle = text;
  //   snackBarSubTitle = subtext;
  //   state = status;
  //   update();
  //   Future.delayed(const Duration(seconds: 2), () {
  //     height = 0;
  //     update();
  //   });
  // }

  @override
  void onInit() {
    isLoading.toggle();
    update();
    getUserFromSession().then((value) {
      getUserFromDb(value.uid).then((value) {
        WUser user = value;
        saveToSession(user);
        isLoading.toggle();
        update();
      });
    });

    super.onInit();
  }
}
