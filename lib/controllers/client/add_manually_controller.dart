import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:washly/utils/models/car_request.dart';
import 'package:washly/utils/models/w_user.dart';
import 'package:washly/views/components/widgets.dart';

class AddManuallyController extends GetxController {
  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  bool suffixIconEnabled = false;
  bool modelsuffixIconEnabled = false;
  RxBool loading = false.obs;
  bool isVerified = false;
  WUser user = WUser();

  void verify() {
    if (makeController.text.isEmpty) {
      isVerified = false;
    } else if (modelController.text.isEmpty) {
      isVerified = false;
    } else {
      isVerified = true;
    }
    update();
  }

  submit() async {
    if (isVerified) {
      loading.toggle();
      update();
      CarRequest carRequest = CarRequest(
        make: makeController.text,
        model: modelController.text,
        wUser: user,
      );
      await FirebaseFirestore.instance
          .collection('carRequests')
          .add(
            carRequest.toJson(),
          )
          .then((DocumentReference doc) async {
        carRequest.uid = doc.id;
        await FirebaseFirestore.instance 
            .collection('carRequests')
            .doc(doc.id)
            .update(
              carRequest.toJson(),
            );

        loading.toggle();
        update();

        carRequestDialog(context: Get.context!);
      });
    } else {}
  }

  @override
  void onInit() {
    user = Get.arguments;
    super.onInit();
  }
}
