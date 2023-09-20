import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:washly/controllers/auth/sign_up_car_controller.dart';

import 'package:washly/utils/constants.dart';
import 'package:washly/utils/glassmorphism.dart';
import 'package:washly/views/components/widgets.dart';

class SignUpCar extends StatelessWidget {
  const SignUpCar({super.key});

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
      child: GetBuilder<SignUpCarController>(
          init: SignUpCarController(),
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
                              child: Icon(CupertinoIcons.car_detailed,
                                  color: Colors.white, size: 30.sp),
                            ),
                          ),
                          15.verticalSpace,
                          Text(
                            'whatcar',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold),
                          ).tr(),
                          24.verticalSpace,
                          Text(
                            'make',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500),
                          ).tr(),
                          12.verticalSpace,
                          GetBuilder<SignUpCarController>(
                              init: SignUpCarController(),
                              builder: (controller) {
                                return Container(
                                    width: double.infinity,
                                    // height: 54.h,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5.r)),
                                    child: CustomDropdown.search(
                                      onChanged: (value) {
                                        controller.modelController.clear();
                                        controller.updateCars();
                                        controller.verify();
                                      },
                                      hintText: tr('selectmake'),
                                      items: controller.carsMake,
                                      controller: controller.makeController,
                                    ));
                              }),
                          34.verticalSpace,
                          Text(
                            'model',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500),
                          ).tr(),
                          13.verticalSpace,
                          GetBuilder<SignUpCarController>(
                              init: SignUpCarController(),
                              builder: (controller) {
                                return Container(
                                    width: double.infinity,
                                    // height: 54.h,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5.r)),
                                    child: CustomDropdown.search(
                                      onChanged: (value) {
                                        controller.verify();
                                      },
                                      hintText: tr('selectmodel'),
                                      items: controller.carsModel,
                                      controller: controller.modelController,
                                    ));
                              }),
                          34.verticalSpace,
                          Text(
                            'licenceplate',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500),
                          ).tr(),
                          12.verticalSpace,
                          GetBuilder<SignUpCarController>(
                              init: SignUpCarController(),
                              builder: (controller) {
                                return TextFieldPrimary(
                                  onTap: () {
                                    controller.verify();
                                  },
                                  onChange: (value) {
                                    controller.verify();
                                  },
                                  controller: controller.licencePlateController,
                                  hint: '',
                                  visible: false,
                                );
                              }),
                          23.verticalSpace,
                          Center(
                            child: Text('youcanaddmorecars',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500))
                                .tr(),
                          ),
                          MediaQuery.of(context).viewInsets.bottom == 0.0
                              ? 105.verticalSpace
                              : 34.verticalSpace,
                          Center(
                            child: SizedBox(
                                width: 356.w,
                                child: GetBuilder<SignUpCarController>(
                                    init: SignUpCarController(),
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
                                                        : const Color(
                                                            0xff459F98),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ).tr(),
                                            ),
                                          ),
                                        ),
                                      );
                                    })),
                          ),
                          43.verticalSpace,
                          Center(
                            child: GetBuilder<SignUpCarController>(
                                init: SignUpCarController(),
                                builder: (controller) {
                                  return InkWell(
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
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  );
          }),
    ));
  }
}
