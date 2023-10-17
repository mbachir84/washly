import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_place/google_place.dart';

import '../../utils/constants.dart';
import '../../utils/models/address.dart';
import '../../utils/models/w_user.dart';
import '../../utils/services.dart';
import 'addresses_list_controller.dart';
import 'main_controller.dart';

class EditAddressController extends GetxController {
  TextEditingController locationNameController = TextEditingController();
  TextEditingController addressSearch = TextEditingController();
  Timer? debounce;
  Address address = Address();
  bool endContainer = false, allowed = true;
  List<AutocompletePrediction> predictions = [];
  GooglePlace googlePlace = GooglePlace(mapKey);
  bool suffixIconEnabled = false;
  RxBool loading = false.obs;
  bool switchValue = false, isDefault = false;
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
          .get(value, language: 'fr', region: 'MA', sessionToken: mapKey);
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
      if (switchValue) {
        for (var element in user.addresses!) {
          element.isDefault = false;
        }
      }
      address.isDefault = switchValue;
      if (user.addresses!
          .where((element) => element.uid == address.uid)
          .isNotEmpty) {
        user.addresses!.removeWhere((element) => element.uid == address.uid);
        user.addresses!.add(address);
      }
      await FirebaseFirestore.instance
          .collection('w_users')
          .doc(user.uid)
          .update({
        'addresses': user.addresses!.map((e) => e.toJson()).toList()
      }).then((value) async {
        Get.find<AddressesListController>().user.addresses = user.addresses!;
        Get.find<AddressesListController>().selectedAddress = address;
        Get.find<MainController>().user.addresses = user.addresses!;
        Get.find<MainController>().update();
        Get.find<AddressesListController>().showScnackbar(
            'addressupdated'.tr(), "addressaddedsuccefully".tr(), true);
        Get.find<AddressesListController>().update();
        FocusManager.instance.primaryFocus?.unfocus();
        Get.delete<EditAddressController>();
        Get.back();
        loading.toggle();
        update();
        await resaveUser();
      });
    }
  }

  deleteAddress() async {
    loading.toggle();
    update();
    user.addresses!.removeWhere((element) => element.uid == address.uid);
    if (user.addresses!.isNotEmpty &&
        user.addresses!.where((element) => element.isDefault!).isEmpty) {
      user.addresses!.first.isDefault = true;
      update();
    }
    await FirebaseFirestore.instance
        .collection('w_users')
        .doc(user.uid)
        .update({
      'addresses': user.addresses!.map((e) => e.toJson()).toList()
    }).then((value) async {
      Get.find<AddressesListController>().user.addresses = user.addresses!;
      Get.find<MainController>().user.addresses = user.addresses!;
      Get.find<MainController>().update();
      Get.find<AddressesListController>().showScnackbar(
          'addressdeleted'.tr(), "addressdeletedsuccessfully".tr(), true);
      Get.find<AddressesListController>().update();
      Get.delete<EditAddressController>();
      Get.back();
      Get.back();
      loading.toggle();
      update();
      await resaveUser();
    });
  }

  @override
  void onInit() {
    address = Get.arguments;
    locationNameController.text = address.name!;
    addressSearch.text = address.description!;
    switchValue = address.isDefault!;
    isDefault = address.isDefault!;
    getUserFromSession().then((value) {
      user = value;
    });
    update();
    super.onInit();
  }
}
