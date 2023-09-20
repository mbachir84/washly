import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:washly/controllers/auth/welcome_controller.dart';
import 'package:washly/utils/buttons.dart';
import 'package:washly/utils/constants.dart';
import 'package:washly/utils/glassmorphism.dart';
import 'package:washly/views/screens/auth/verify_phone.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
            Image.asset(
              'assets/images/logo_splash.png',
              width: 265.w,
            ),
            25.verticalSpace,
            Text(
              'carclean',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold),
            ).tr(),
            const Spacer(),
            PrimaryButton(
              text: 'getstarted',
              onpress: () {
                Get.to(() => const VerifyPhoneScreen());
              },
            ),
            21.verticalSpace,
            GetBuilder<WelcomeController>(
                init: WelcomeController(),
                builder: (controller) {
                  return InkWell(
                    onTap: () {
                      controller.tryGuest();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VerifyPhoneScreen()),
                      );
                    },
                    child: Glassmorphism(
                      blur: 80,
                      opacity: 0.2,
                      radius: 34.r,
                      child: Container(
                        height: 67.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(34.r)),
                        child: Center(
                          child: Text(
                            'tryguest',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 19.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                      ),
                    ),
                  );
                }),
            56.verticalSpace,
          ],
        ),
      ),
    ));
  }
}
