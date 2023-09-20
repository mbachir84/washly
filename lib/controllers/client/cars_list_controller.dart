import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:washly/utils/models/w_user.dart';
import 'package:washly/utils/services.dart';

class CarsListController extends GetxController {
  WUser user = WUser();
  RxBool isLoading = false.obs;
  bool carShow = false;
  Car selectedCar = Car();
  double height = 0;
  String snackBarTitle = "";
  String snackBarSubTitle = "";
  bool state = false;
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
  void onInit() async {
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
