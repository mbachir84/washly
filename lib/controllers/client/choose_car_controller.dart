import 'package:get/get.dart';
import 'package:washly/utils/models/w_user.dart';
import 'package:washly/utils/services.dart';


class ChooseCarController extends GetxController {
  WUser user = WUser();
  RxBool isLoading = false.obs;
  Car selectedCar = Car();
  @override
  void onInit() async {
    isLoading.toggle();
    update();
    await getUserFromSession().then((value) {
      user = value;
      selectedCar = user.cars[0];
      isLoading.toggle();
      update();
    });
    super.onInit();
  }
}
