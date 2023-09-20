import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:washly/controllers/auth/verify_phone_controller.dart'; 
import 'package:washly/utils/glassmorphism.dart';

import '../../../utils/constants.dart'; 

class VerifyPhoneScreen extends StatelessWidget {
  const VerifyPhoneScreen({super.key});

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
        child: GetBuilder<VerifyPhoneController>(
            init: VerifyPhoneController(),
            builder: (cont) {
              return cont.loading.value
                  ? Center(
                      child: SpinKitDoubleBounce(
                      color: Colors.white,
                      size: 120.0.sp,
                    ))
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 37.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            79.verticalSpace,
                            Text(
                              'whatsyourphone',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21.sp,
                                  fontWeight: FontWeight.bold),
                            ).tr(),
                            7.verticalSpace,
                            Text(
                              'wewilltext',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.sp,
                              ),
                            ).tr(),
                            39.verticalSpace,
                            GetBuilder<VerifyPhoneController>(
                                init: VerifyPhoneController(),
                                builder: (controller) {
                                  return SizedBox(
                                    height: 115.h,
                                    child: IntlPhoneField(
                                      autofocus: true,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(9),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      disableLengthCheck: true,
                                      showDropdownIcon: false,
                                      showCountryFlag: false,
                                      onChanged: (phone) {
                                        controller.verifyPhone();
                                      },
                                      controller: controller.phoneController,
                                      key: super.key,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintStyle: TextStyle(
                                          fontSize: 21.sp,
                                          color: Colors.grey,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          borderSide: const BorderSide(
                                              color: borderGreyColor),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          borderSide:
                                              const BorderSide(color: primaryColor),
                                        ),
                                      ),
                                      initialCountryCode: 'MA',
                                      invalidNumberMessage: '',
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    );
            }),
      ),
      bottomNavigationBar: GetBuilder<VerifyPhoneController>(
          init: VerifyPhoneController(),
          builder: (controller) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                color: secondaryColor,
                height: 100.h,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Glassmorphism(
                              blur: 100,
                              opacity: 0.3,
                              radius: 100.r,
                              child: Container(
                                  height: 46.w,
                                  width: 46.w,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius:
                                          BorderRadius.circular(100.r)),
                                  child: IconButton(
                                    icon: Icon(
                                      CupertinoIcons.lock_fill,
                                      size: 24.sp,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ))),
                          14.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'datasafe',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.sp,
                                ),
                              ).tr(),
                              5.verticalSpace,
                              Text(
                                'noshare',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                ),
                              ).tr(),
                            ],
                          ),
                          const Spacer(),
                          Glassmorphism(
                            blur: 100,
                            opacity: controller.allowed ? 0.9 : 0.4,
                            radius: 100.r,
                            child: SizedBox(
                              height: 71.h,
                              width: 71.h,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(500.r),
                                    ),
                                  ),
                                  onPressed: () {
                                    controller.allowed
                                        ? controller.submit()
                                        : null;
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 24.sp,
                                        color: secondaryColor,
                                      ),
                                    ],
                                  )),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
