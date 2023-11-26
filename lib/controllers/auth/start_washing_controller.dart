import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:washly/utils/services.dart';
import 'package:washly/views/screens/client/home_screen.dart';

import '../../utils/models/w_user.dart';

class StartWashingController extends GetxController {
  RxBool isLoading = false.obs;
  submit() async {
    isLoading.toggle();
    update();
    WUser user = WUser();
    
    await getUserFromSession().then((value) async {
      user = value;
        getUserFromDb(value.uid).then((value)async {
        WUser user = value;
        saveToSession(user); 
        update();
          await FirebaseFirestore.instance
          .collection('w_users')
          .doc(user.uid)
          .update({'current_page': "homeScreen"}).then((value) async {
        isLoading.toggle();
        update();
        Get.offAll(() => const HomeScreen(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 500));
      });
      });
    
    });
  }
}
