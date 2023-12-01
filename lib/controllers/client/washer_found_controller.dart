import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:washly/views/components/widgets.dart';

class WasherFoundController extends GetxController {
  bool washStarted = false;
  showBottomDialog(BuildContext context) {
    showOrderDialog(context: context, status: false);
  }

  @override
  void onInit() {
    Timer(const Duration(seconds: 1), () {
      showBottomDialog(
        Get.context!,
      );
    });
    Timer(const Duration(seconds: 5), () {
      washStarted = true;
      Get.back();
      showWashStarted(context: Get.context!, status: false);
      update();
    });
    // TODO: implement onInit
    super.onInit();
  }
}
