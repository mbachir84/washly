import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:washly/utils/models/address.dart';
import 'package:washly/utils/models/w_user.dart';
import 'package:washly/utils/services.dart';

import '../../views/screens/auth/sign_up_about.dart';

class SignUpLocationController extends GetxController {
  String address = 'Nous ne pouvons pas obtenir votre position actuelle';
  LatLng? location;
  RxBool isLoading = false.obs;
  bool mapCreated = false;

  Address selectedAddress = Address();

  getMyLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    location = LatLng(position.latitude, position.longitude);
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude,
        localeIdentifier: "fr_FR");
    selectedAddress.latitude = position.latitude;
    selectedAddress.name = "Home";
    selectedAddress.isDefault = true;
    selectedAddress.uid = generateRandomString(21);
    selectedAddress.longitude = position.longitude;
    for (int i = 0; i < placemarks.length; i++) {
      if (placemarks[i].thoroughfare != "") {
        selectedAddress.description = placemarks[i].thoroughfare!;
        break;
      }
    }
  }

  skip() async {
    isLoading.toggle();
    update();
    WUser user = WUser();
    await getUserFromSession().then((value) async {
      user = value;
      await FirebaseFirestore.instance
          .collection('w_users')
          .doc(user.uid)
          .update({'current_page': "signUpAbout"}).then((value) async {
        isLoading.toggle();
        update();
        Get.to(() => const SignUpAbout(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 500));
      });
    });
  }

  submit() async {
    isLoading.toggle();
    update();
    WUser user = WUser();
    await getUserFromSession().then((value) async {
      user = value;
      await FirebaseFirestore.instance
          .collection('w_users')
          .doc(user.uid)
          .update({
        'addresses': FieldValue.arrayUnion([selectedAddress.toJson()]),
        'current_page': "signUpAbout"
      }).then((value) async {
        isLoading.toggle();
        update();
        Get.to(() => const SignUpAbout(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 500));
      });
    });
  }

  handlePermissions() async {
    isLoading.value = true;
    update();
    await handlerPermission().then((value) async {
      await getMyLocation().then((value) {
        mapCreated = true;
        isLoading.value = false;
        update();
      });
    });
  }
}
