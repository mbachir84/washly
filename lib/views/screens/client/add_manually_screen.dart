import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:washly/controllers/client/add_manually_controller.dart';
import 'package:washly/utils/buttons.dart';

class AddManuallyScreen extends StatelessWidget {
  const AddManuallyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: GetBuilder<AddManuallyController>(
            init: AddManuallyController(),
            builder: (controller) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                child: GradientButton(
                  loading: controller.loading.value,
                  allowed: controller.isVerified,
                  text: "Save Car",
                  onpress: () {
                    controller.submit();
                  },
                ),
              );
            }),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: GetBuilder<AddManuallyController>(
              init: AddManuallyController(),
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    85.verticalSpace,
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: SvgPicture.asset(
                              'assets/images/arrow-back.svg',
                              height: 9.h,
                              width: 17,
                            )),
                        9.horizontalSpace,
                        Text(
                          'addmanually',
                          style: TextStyle(
                            fontSize: 22.sp,
                            color: const Color(0xff030303),
                            fontWeight: FontWeight.bold,
                          ),
                        ).tr(),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'cancel',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ).tr())
                      ],
                    ),
                    23.verticalSpace,
                    Text(
                      'request',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: const Color(0xff030303)),
                    ).tr(),
                    10.verticalSpace,
                    Text(
                      'weredoing',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          color: const Color(0xff698695)),
                    ).tr(),
                    25.verticalSpace,
                    Text(
                      'make',
                      style: TextStyle(
                          color: const Color(0xff698695),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500),
                    ).tr(),
                    12.verticalSpace,
                    SizedBox(
                      width: double.infinity,
                      height: 54.h,
                      child: TextField(
                        controller: controller.makeController,
                        onChanged: (value) {
                          controller.suffixIconEnabled = value.isNotEmpty;
                          controller.verify();
                        },
                        decoration: InputDecoration(
                            suffixIcon: controller.suffixIconEnabled
                                ? InkWell(
                                    onTap: () {
                                      controller.suffixIconEnabled = false;

                                      controller.makeController.clear();
                                      controller.verify();
                                    },
                                    child: Icon(
                                      CupertinoIcons.xmark_circle_fill,
                                      color: Colors.grey.withOpacity(0.5),
                                      size: 24.w,
                                    ),
                                  )
                                : null,
                            hintStyle: TextStyle(
                                color: const Color(0xff698695),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.r),
                                borderSide: BorderSide(
                                    color: const Color(0xff698695), width: 1.w)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.r),
                                borderSide: BorderSide(
                                    color: const Color(0xff698695), width: 1.w))),
                      ),
                    ),
                    25.verticalSpace,
                    Text(
                      'model',
                      style: TextStyle(
                          color: const Color(0xff698695),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500),
                    ).tr(),
                    12.verticalSpace,
                    SizedBox(
                      width: double.infinity,
                      height: 54.h,
                      child: TextField(
                        controller: controller.modelController,
                        onChanged: (value) {
                          controller.modelsuffixIconEnabled = value.isNotEmpty;
                          controller.verify();
                        },
                        decoration: InputDecoration(
                            suffixIcon: controller.modelsuffixIconEnabled
                                ? InkWell(
                                    onTap: () {
                                      controller.modelsuffixIconEnabled = false;

                                      controller.modelController.clear();
                                      controller.verify();
                                    },
                                    child: Icon(
                                      CupertinoIcons.xmark_circle_fill,
                                      color: Colors.grey.withOpacity(0.5),
                                      size: 24.w,
                                    ),
                                  )
                                : null,
                            hintStyle: TextStyle(
                                color: const Color(0xff698695),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.r),
                                borderSide: BorderSide(
                                    color: const Color(0xff698695), width: 1.w)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.r),
                                borderSide: BorderSide(
                                    color: const Color(0xff698695), width: 1.w))),
                      ),
                    )
                  ],
                );
              }),
        ));
  }
}
