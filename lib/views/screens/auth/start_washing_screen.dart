import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:washly/utils/buttons.dart';
import 'package:washly/utils/constants.dart';

import '../../../controllers/auth/start_washing_controller.dart'; 

class StartWashingScreen extends StatelessWidget {
  const StartWashingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            primaryColor,
            secondaryColor,
          ])),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 37.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Icon(
              CupertinoIcons.checkmark_alt_circle_fill,
              color: Colors.white,
              size: 59.w,
            ),
            20.verticalSpace,
            Text(
              'yourset',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 34.sp,
                  fontWeight: FontWeight.bold),
            ).tr(),
            13.verticalSpace,
            Text(
              'keepcarshiny',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w500),
            ).tr(),
            const Spacer(),
            GetBuilder<StartWashingController>(
                init: StartWashingController(),
                builder: (controller) {
                  return PrimaryButton(
                    text: 'startwashing',
                    onpress: () {
                      controller.submit();
                      // Get.to(() => VerifyPhoneScreen());
                    },
                  );
                }),
            52.verticalSpace,
          ],
        ),
      ),
    ));
  }
}
