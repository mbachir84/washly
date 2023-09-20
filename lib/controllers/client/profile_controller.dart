import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:washly/utils/models/w_user.dart';
import 'package:washly/utils/services.dart';

class ProfileController extends GetxController {
  WUser? user;

  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    loading = true;
    update();

    getUserFromSession().then((value) {
      user = value;
      loading = false;

      update();
    });
  }
}
