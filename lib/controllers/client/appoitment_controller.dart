import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:washly/controllers/client/main_controller.dart';
import 'package:washly/utils/models/appointment.dart';
import 'package:washly/utils/models/w_user.dart';
import 'package:washly/utils/services.dart';

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

  Appointment appointment = Appointment( //date,carDetails,
      uid: "uid",
      status: "scheduled",
      paymentInformation: "Credit Card");
      
  submit() {
    FirebaseFirestore.instance
        .collection("appointment")
        .add(appointment.toJson());
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
