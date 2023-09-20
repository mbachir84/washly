import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:washly/controllers/auth/verify_code_controller.dart';
import 'package:washly/utils/constants.dart';
import 'package:washly/utils/glassmorphism.dart';
import 'package:washly/views/components/widgets.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key});

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
        child: Column(
          children: [
            GetBuilder<VerifyCodeController>(
                init: VerifyCodeController(),
                builder: (controller) {
                  return AnimatedSnackbar(
                      height: controller.height,
                      title: controller.snackBarTitle,
                      subtitle: controller.snackBarSubTitle,
                      state: controller.state);
                }),
            GetBuilder<VerifyCodeController>(
                init: VerifyCodeController(),
                builder: (cont) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 37.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          79.verticalSpace,
                          // cont.loading.value
                          //     ? Center(
                          //         child: SpinKitDoubleBounce(
                          //         color: Colors.white,
                          //         size: 100.0.sp,
                          //       ))
                          //     :
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(Icons.arrow_back_rounded,
                                    color: Colors.white, size: 24.sp),
                              ),
                              14.horizontalSpace,
                              Text(
                                'thecode',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21.sp,
                                    fontWeight: FontWeight.bold),
                              ).tr(),
                            ],
                          ),
                          7.verticalSpace,
                          Row(
                            children: [
                              35.horizontalSpace,
                              GetBuilder<VerifyCodeController>(
                                  init: VerifyCodeController(),
                                  builder: (controller) {
                                    return Text(
                                      plural('codesent', 0,
                                          args: [controller.phoneNumber]),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.sp,
                                      ),
                                    ).tr();
                                  }),
                            ],
                          ),
                          107.verticalSpace,
                          GetBuilder<VerifyCodeController>(
                              init: VerifyCodeController(),
                              builder: (controller) {
                                return Center(
                                    child: PinCodeTextField(
                                  autoFocus: true,
                                  backgroundColor: Colors.transparent,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(6),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  length: 6,
                                  obscureText: false,
                                  keyboardType: TextInputType.number,
                                  animationType: AnimationType.fade,
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold),
                                  enablePinAutofill: true,
                                  pinTheme: PinTheme(
                                    disabledColor: Colors.transparent,
                                    inactiveFillColor: Colors.transparent,
                                    selectedColor: Colors.white,
                                    selectedFillColor: Colors.transparent,
                                    errorBorderColor: Colors.transparent,
                                    activeColor: Colors.white,
                                    inactiveColor: Colors.white,
                                    shape: PinCodeFieldShape.underline,
                                    fieldHeight: 60,
                                    fieldWidth: 40,
                                    activeFillColor: Colors.transparent,
                                  ),
                                  animationDuration:
                                      const Duration(milliseconds: 300),
                                  enableActiveFill: true,
                                  // errorAnimationController: errorController,
                                  controller: controller.pinController,
                                  onCompleted: (v) {
                                    controller.allowed = true;
                                    controller.pinController.text = v;
                                    controller.update();
                                  },
                                  onChanged: (value) {
                                    controller.allowed = false;
                                    controller.update();
                                  },

                                  beforeTextPaste: (text) {
                                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                    return true;
                                  },
                                  appContext: context,
                                ));
                              }),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
      bottomNavigationBar: GetBuilder<VerifyCodeController>(
          init: VerifyCodeController(),
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
                                      Icons.sms_rounded,
                                      size: 24.sp,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ))),
                          14.horizontalSpace,
                          InkWell(
                            onTap: () {
                              controller.reverify();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'didntcode',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.sp,
                                  ),
                                ).tr(),
                                5.verticalSpace,
                                Text(
                                  'resend',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                  ),
                                ).tr(),
                              ],
                            ),
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
                                    controller.allowed &&
                                            !controller.loading.value
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
