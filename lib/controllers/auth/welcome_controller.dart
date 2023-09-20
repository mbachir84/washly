import 'package:get/get.dart';
import 'package:washly/views/screens/auth/verify_phone.dart';

class WelcomeController extends GetxController {
  getStartedAction() {
    Get.to(() => const VerifyPhoneScreen());
  }

  tryGuest() {
    
  }
}
