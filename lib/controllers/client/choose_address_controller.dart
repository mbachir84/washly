import 'package:get/get.dart';

import '../../utils/models/address.dart';

class ChooseAddressController extends GetxController {
  RxBool isLoading = false.obs;
  Address selectedAddress = Address();
  List<Address> addresses = [
    Address(
        uid: "saldkfj",
        name: "Home",
        description: "rez de, 443 Bd Al Hassan Al Alaoui",
        isDefault: true),
    Address(
        uid: "saldkfj",
        name: "Work",
        description: "H9FR+QM4, Casablanca 20250, Mor...",
        isDefault: false),
    Address(
        uid: "saldkfj",
        name: "Gym",
        description: "H98G+RJ5, Casablanca 20250, Moro...",
        isDefault: false),
  ];

  @override
  void onInit() async {
    selectedAddress = addresses[0];
    update();
    super.onInit();
  }
}
