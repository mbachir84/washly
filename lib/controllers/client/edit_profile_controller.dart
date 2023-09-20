import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Trans;
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:washly/controllers/client/profile_controller.dart';
import 'package:washly/utils/models/w_user.dart';
import 'package:washly/utils/services.dart';

class EditProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  ImagePicker picker = ImagePicker();
  XFile? image;
  WUser? user;
  bool isVerified = true;
  bool isLoading = true;
  String snackBarTitle = "";
  String snackBarSubTitle = "";
  bool state = false;
  double height = 0;

  verify() {
    if (emailController.text.isEmpty) {
      isVerified = false;
    } else if (nameController.text.isEmpty) {
      isVerified = false;
    } else if (nameController.text.length < 3) {
      isVerified = false;
    } else if (!GetUtils.isEmail(emailController.text.trim().toLowerCase())) {
      isVerified = false;
    } else {
      isVerified = true;
    }
    update();
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

  updateProfile() async {
    if (isVerified) {
      isLoading = true;
      update();
      // Get.snackbar('good', 'good message');
      // Get.to(() => SignUpCar());
      if (image != null) {
        await FirebaseStorage.instance
            .ref('profiles_pictures')
            .putFile(File(image!.path))
            .then((p0) {
          p0.ref.getDownloadURL().then((value) async {
            user!.profileImage = value;
            user!.fullname = nameController.text;
            user!.email = emailController.text;
            print(user!.uid);
            await FirebaseFirestore.instance
                .collection('w_users')
                .doc(user!.uid)
                .update(user!.toJson());
            await saveToSession(user!);
            isLoading = false;
            update();
            Get.back();
            Get.delete<ProfileController>();
            showScnackbar('success', 'profileupdatedsuccess', true);
          });
        });
      } else {
        user!.fullname = nameController.text;
        user!.email = emailController.text;

        await FirebaseFirestore.instance
            .collection('w_users')
            .doc(user!.uid)
            .update(user!.toJson());
        await saveToSession(user!);
        isLoading = false;
        update();
        Get.back();
        Get.delete<ProfileController>();
      }
    } else {}
  }

  pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = pickedFile;
      update();
    }
  }

  @override
  void onInit() {
    getUserFromSession().then((value) {
      user = value;
      nameController.text = value.fullname!;
      emailController.text = value.email!;
      phoneController.text =
          PhoneNumber.fromCompleteNumber(completeNumber: value.phoneNumber!)
              .number;
      isLoading = false;
      update();
    });
    super.onInit();
  }
}
