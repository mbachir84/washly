import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washly/utils/constants.dart';
import 'package:washly/utils/services.dart';

import 'controllers/client/addresses_list_controller.dart';
import 'controllers/client/main_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await handlerPermission();
  Widget? main;
  Get.put(AddressesListController()); 
  Get.put(MainController());
  await initWidget().then(
    (value) {
      main = value;
    },
  );
  runApp(EasyLocalization(
    supportedLocales: supportedLocales,
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    startLocale: const Locale("en"),
    child: ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return GetMaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'Washly',
          theme: ThemeData(
            textTheme: GoogleFonts.montserratTextTheme(),
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: primaryColor,
                ),
            primaryColor: primaryColor,
          ),
          home: main,
        );
      },
    ),
  ));
}
