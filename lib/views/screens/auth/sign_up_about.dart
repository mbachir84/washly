import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:washly/controllers/auth/sign_up_about_controller.dart';
import 'package:washly/utils/constants.dart';
import 'package:washly/utils/glassmorphism.dart';

import '../../components/widgets.dart';

class SignUpAbout extends StatelessWidget {
  const SignUpAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: 932.h,
      width: 430.w,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            primaryColor,
            secondaryColor,
          ])),
      child: GetBuilder<SignUpAboutController>(
          init: SignUpAboutController(),
          builder: (cont) {
            return cont.isLoading.value
                ? Center(
                    child: SpinKitDoubleBounce(
                    color: Colors.white,
                    size: 100.0.sp,
                  ))
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 29.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          84.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 5.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2.5.r)),
                              ),
                              Container(
                                height: 5.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2.5.r)),
                              ),
                              Container(
                                height: 5.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(2.5.r)),
                              ),
                              Container(
                                height: 5.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(2.5.r)),
                              ),
                            ],
                          ),
                          34.verticalSpace,
                          Glassmorphism(
                            blur: 80,
                            opacity: 0.2,
                            radius: 90.r,
                            child: SizedBox(
                              width: 62.w,
                              height: 62.w,
                              child: Icon(Icons.person_rounded,
                                  color: Colors.white, size: 30.sp),
                            ),
                          ),
                          15.verticalSpace,
                          Text(
                            'knowyou',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold),
                          ).tr(),
                          24.verticalSpace,
                          Text(
                            'fullname',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500),
                          ).tr(),
                          12.verticalSpace,
                          GetBuilder<SignUpAboutController>(
                              init: SignUpAboutController(),
                              builder: (controller) {
                                return TextFieldPrimary(
                                  onTap: () {
                                    controller.verify();
                                  },
                                  onChange: (value) {
                                    controller.verify();
                                  },
                                  controller: controller.fullNameController,
                                  hint: '',
                                  visible: false,
                                );
                              }),
                          34.verticalSpace,
                          Text(
                            'emailaddress',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500),
                          ).tr(),
                          12.verticalSpace,
                          GetBuilder<SignUpAboutController>(
                              init: SignUpAboutController(),
                              builder: (controller) {
                                return TextFieldPrimary(
                                  onChange: (value) {
                                    controller.verify();
                                  },
                                  onTap: () {
                                    controller.verify();
                                  },
                                  controller: controller.emailController,
                                  hint: '',
                                  visible: false,
                                );
                              }),
                          MediaQuery.of(context).viewInsets.bottom == 0.0
                              ? 266.verticalSpace
                              : 34.verticalSpace,
                          Center(
                            child: SizedBox(
                                width: 356.w,
                                child: GetBuilder<SignUpAboutController>(
                                    init: SignUpAboutController(),
                                    builder: (controller) {
                                      return InkWell(
                                        onTap: () {
                                          controller.submit();
                                        },
                                        child: Glassmorphism(
                                          blur: 9,
                                          opacity:
                                              controller.isVerified ? 1.0 : 0.2,
                                          radius: 34.r,
                                          child: Container(
                                            height: 67.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        34.r)),
                                            child: Center(
                                              child: Text(
                                                'next',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 19.sp,
                                                    color: controller.isVerified
                                                        ? darkColor
                                                        : const Color(0xff459F98),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ).tr(),
                                            ),
                                          ),
                                        ),
                                      );
                                    })),
                          ),
                          MediaQuery.of(context).viewInsets.bottom == 0.0
                              ? 43.verticalSpace
                              : 10.verticalSpace,
                          GetBuilder<SignUpAboutController>(
                              init: SignUpAboutController(),
                              builder: (controller) {
                                return Center(
                                  child: InkWell(
                                    onTap: () {
                                      controller.skip();
                                    },
                                    child: Text(
                                      'skiplater',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.bold),
                                    ).tr(),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  );
          }),
    ));
  }
}
