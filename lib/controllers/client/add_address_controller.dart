import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:washly/controllers/client/addresses_list_controller.dart';
import 'package:washly/controllers/client/main_controller.dart';
import 'package:washly/utils/models/w_user.dart';

import '../../utils/constants.dart';
import '../../utils/models/address.dart';
import '../../utils/services.dart';

class AddAddressController extends GetxController {
  TextEditingController locationNameController = TextEditingController();
  TextEditingController addressSearch = TextEditingController();
  Timer? debounce;
  Address address = Address();
  bool endContainer = false, allowed = false;
  List<AutocompletePrediction> predictions = [];
  GooglePlace googlePlace = GooglePlace(newMapKey);
  bool suffixIconEnabled = false;
  RxBool loading = false.obs;
  bool switchValue = false;
  WUser user = WUser();
  verify() {
    if (locationNameController.text.isNotEmpty &&
        addressSearch.text.isNotEmpty &&
        address.longitude != null &&
        address.latitude != null) {
      allowed = true;
      update();
    } else {
      allowed = false;
      update();
    }
  }

  void autoCompleteSearch(String value) async {
    try {
      var result = await googlePlace.autocomplete
          .get(value, language: 'fr', region: 'MA', sessionToken: newMapKey);
      if (result != null && result.predictions != null) {
        predictions = result.predictions!;
        update();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  void submit() async {
    if (allowed) {
      loading.toggle();
      update();
      address.name = locationNameController.text;
      address.description = addressSearch.text;
      address.isDefault = switchValue;
      address.uid = generateRandomString(21);
      if (switchValue) {
        for (var element in user.addresses!) {
          element.isDefault = false;
        }
      }
      user.addresses!.add(address);
      await FirebaseFirestore.instance
          .collection('w_users')
          .doc(user.uid)
          .update({
        'addresses': user.addresses!.map((e) => e.toJson()).toList()
      }).then((value) async {
        final addressListController = Get.put(AddressesListController());
        
        final mainController = Get.put(MainController());
        addressListController.user.addresses = user.addresses!;
        mainController.user.addresses = user.addresses!;
        saveToSession(user);
        mainController.update();
        addressListController.showScnackbar(
            'New address added', "Super Market address added", true);
        addressListController.update();
        FocusManager.instance.primaryFocus?.unfocus();
        Get.delete<AddAddressController>();
        Get.back();

        loading.toggle();
        update();
        await resaveUser();
      });
    }
  }

  @override
  void onInit() {
    getUserFromSession().then((value) {
      user = value;
    });
    // TODO: implement onInit
    super.onInit();
  }
}
