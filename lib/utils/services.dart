import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:washly/utils/models/w_user.dart';
import 'package:washly/views/screens/auth/sign_up_about.dart';
import 'package:washly/views/screens/auth/sign_up_car.dart';
import 'package:washly/views/screens/auth/sign_up_location.dart';
import 'package:washly/views/screens/auth/start_washing_screen.dart';
import 'package:washly/views/screens/auth/welcome_screen.dart';
import 'dart:math';
import '../views/screens/client/home_screen.dart';
import '../views/screens/auth/sign_up_credit_card.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

Future<Widget> initWidget() async {
  Widget? main;

  await getUserFromSession().then((value) async {
    if (value.uid == null) {
      main = const WelcomeScreen();
    } else {
      await getUserFromDb(value.uid).then((value) {
        switch (value.currentPage) {
          case 'signUpLocation':
            main = const SignUpLocation();
            break;

          case 'signUpAbout':
            main = const SignUpAbout();
            break;
          case 'signUpCreditCard':
            main = const SignUpCreditCard();
            break;
          case 'signUpCar':
            main = const SignUpCar();
            break;
          case 'startWashingScreen':
            main = const StartWashingScreen();
            break;
          case 'homeScreen':
            main = const HomeScreen();
            break;

          default:
            main = const WelcomeScreen();
        }
      });
    }
  });

  return main!;
}

handlerPermission() async {
  var permission = await Permission.sensors.status;
  if (Platform.isIOS) {
    Geolocator.requestPermission();
  }
  if (permission.isDenied) {
    await Permission.phone.request();
    await Permission.location.request();
    // await Permission.locationAlways.request();
  }
  if (permission.isRestricted) {
    await Permission.phone.request();
    await Permission.location.request();
    // await Permission.locationAlways.request();
  }
  if (permission.isPermanentlyDenied) {
    await Permission.phone.request();
    await Permission.location.request();
    // await Permission.locationAlways.request();
  }
  if (permission.isLimited) {
    await Permission.phone.request();
    await Permission.location.request();
    // await Permission.locationAlways.request();
  }
}

Future<String> checkPhoneNumber(uid) async {
  String message = "not-found";
  await FirebaseFirestore.instance
      .collection('w_users')
      .doc(uid)
      .get()
      .then((value) {
    if (value.exists) message = "found-in-users";
  });
  return message;
}

saveUserToDb(WUser user) async {
  await FirebaseFirestore.instance
      .collection('w_users')
      .doc(user.uid)
      .set(user.toJson());
}

Future<WUser> getUserFromDb(uid) async {
  WUser snUser = WUser();
  await FirebaseFirestore.instance
      .collection('w_users')
      .doc(uid)
      .get()
      .then((value) {
    if (value.exists) snUser = WUser.fromJson(value.data()!);
  });
  return snUser;
}

saveToSession(WUser user) async {
  await SessionManager().set("user", user);
}

Future<WUser> getUserFromSession() async {
  return WUser.fromJson(await SessionManager().get("user") ?? {});
}

resaveUser() async {
  await getUserFromSession().then((value) async {
    await getUserFromDb(value.uid).then((value) async {
      await saveToSession(value);
    });
  });
}

String generateRandomString(int length) {
  final random = Random();
  const availableChars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final randomString = List.generate(length,
      (index) => availableChars[random.nextInt(availableChars.length)]).join();

  return randomString;
}

////
void updateCarsDocument() async {
  var collection = FirebaseFirestore.instance.collection("cars");
  var allDocs = await collection.get();

  for (var i = 0; i < allDocs.docs.length; i++) {
    print("doc $i ${allDocs.docs[i].id}");
    collection.doc(allDocs.docs[i].id).update
    ({"uid": allDocs.docs[i].id},).then((value) => print("added"));
  }
  var docID = allDocs.docs[2].id;
  print("car document is $docID");
}
