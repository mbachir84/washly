import 'package:get/get.dart';
import 'package:washly/controllers/client/addresses_list_controller.dart';
import 'package:washly/controllers/client/main_controller.dart';
import 'package:washly/utils/models/w_user.dart';
import 'package:washly/utils/services.dart';

class ChooseCarController extends GetxController {
  WUser user = WUser();
  RxBool isLoading = false.obs;
  Car selectedCar = Car();

  @override
  void onInit() async {
    Get.put(MainController());
    Get.put(AddressesListController());

    isLoading.toggle();
    update();
    await getUserFromSession().then((value) {
      user = value;
      selectedCar = user.cars[0];
      //print("mouad car ${user.cars.isNotEmpty}");
      isLoading.toggle();
      update();
    });
    print("mouad car ${user.addresses![0].name}");

    super.onInit();
  }
}
