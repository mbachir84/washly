import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:washly/views/components/widgets.dart';

class WasherFoundController extends GetxController {
  showBottomDialog(BuildContext context) {
    showOrderDialog(context: Get.context!, status: false);
  }

  @override
  void onInit() {
    Timer(const Duration(seconds: 1), () {
      showBottomDialog(
        Get.context!,
      );
    });
    // TODO: implement onInit
    super.onInit();
  }
}
