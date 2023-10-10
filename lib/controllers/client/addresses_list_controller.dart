import 'package:get/get.dart';
import 'package:washly/utils/models/w_user.dart';

import '../../utils/services.dart';

class AddressesListController extends GetxController {
  WUser user = WUser();
  RxBool isLoading = false.obs;
  Car selectedCar = Car();
  double height = 0;
  String snackBarTitle = "";
  String snackBarSubTitle = "";
  bool state = false;
  String addressSelected = "";
  List<String> addressInfo = [];

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

  @override
  Future<void> onInit() async {
    isLoading.toggle();
    update();
    await getUserFromSession().then((value) {
      user = value;
      isLoading.toggle();
      update();
    });
    super.onInit();
  }
}
