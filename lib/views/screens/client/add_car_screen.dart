// import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:washly/controllers/client/add_car_controller.dart';
import 'package:washly/utils/buttons.dart';

import 'add_manually_screen.dart';
import '../../components/widgets.dart';

class AddCarScreen extends StatelessWidget {
  const AddCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: GetBuilder<AddCarController>(
            init: AddCarController(),
            builder: (controller) {
              return SizedBox(
                width: 382.w,
                height: 67.h,
                child: GradientButton(
                  loading: controller.isLoading.value,
                  allowed: controller.isVerified,
                  text: 'savecar',
                  onpress: () {
                    
                    controller.submit();
                  },
                ),
              );
            }),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                83.verticalSpace,
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          showCancel(
                            context: context,
                            allowBackNavigation: true,
                          );
                        },
                        icon: SvgPicture.asset(
                          'assets/images/arrow-back.svg',
                          height: 9.h,
                          width: 17,
                        )),
                    16.horizontalSpace,
                    Text(
                      'addcarwi',
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: const Color(0xff030303),
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          showCancel(
                            context: context,
                            allowBackNavigation: true,
                          );
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
                29.verticalSpace,
                GetBuilder<AddCarController>(
                    init: AddCarController(),
                    builder: (controller) {
                      return InkWell(
                        onTap: () {
                          controller.selectImage();
                        },
                        child: controller.file == null
                            ? Container(
                                height: 200.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: const Color(0xffd7f0fd),
                                    border: Border.all(
                                        color: const Color(0xff10a7f5), width: 1.w),
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/camera-icon.svg'),
                                    17.verticalSpace,
                                    SizedBox(
                                      width: 188.w,
                                      child: Text(
                                        'addcarphoto',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          color: const Color(0xff10a7f5),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ).tr(),
                                    )
                                  ],
                                ))
                            : Stack(
                                children: [
                                  SizedBox(
                                    height: 200.h,
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Image.file(
                                        controller.image!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: InkWell(
                                        onTap: () {
                                          controller.removeImage();
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 17.w, right: 17.h),
                                          child: SvgPicture.asset(
                                            'assets/images/remove.svg',
                                            height: 27.w,
                                            width: 27.w,
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                      );
                    }),
                28.verticalSpace,
                Text(
                  'make',
                  style: TextStyle(
                      color: const Color(0xff698695),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500),
                ).tr(),
                12.verticalSpace,
                GetBuilder<AddCarController>(
                    init: AddCarController(),
                    builder: (controller) {
                      return SizedBox(
                          width: double.infinity,
                          height: 54.h,
                          child: CustomDropdown.search(
                            selectedStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500),
                            borderSide: BorderSide(
                                color: const Color(0xff698695), width: 1.w),
                            borderRadius: BorderRadius.circular(5.r),
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
                27.verticalSpace,
                Text(
                  'model',
                  style: TextStyle(
                      color: const Color(0xff698695),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500),
                ).tr(),
                12.verticalSpace,
                GetBuilder<AddCarController>(
                    init: AddCarController(),
                    builder: (controller) {
                      return SizedBox(
                          width: double.infinity,
                          height: 54.h,
                          child: CustomDropdown.search(
                            borderSide: BorderSide(
                                color: const Color(0xff698695), width: 1.w),
                            borderRadius: BorderRadius.circular(5.r),
                            selectedStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500),
                            onChanged: (value) {
                              controller.verify();
                            },
                            hintText: tr('selectmodel'),
                            items: controller.carsModel,
                            controller: controller.modelController,
                          ));
                    }),
                27.verticalSpace,
                Text(
                  'licenceplate',
                  style: TextStyle(
                      color: const Color(0xff698695),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500),
                ).tr(),
                12.verticalSpace,
                GetBuilder<AddCarController>(
                    init: AddCarController(),
                    builder: (controller) {
                      return SizedBox(
                        width: double.infinity,
                        height: 54.h,
                        child: TextField(
                          controller: controller.licencePlateController,
                          onChanged: (value) {
                            controller.suffixIconEnabled = value.isNotEmpty;
                            controller.verify();
                          },
                          decoration: InputDecoration(
                              suffixIcon: controller.suffixIconEnabled
                                  ? InkWell(
                                      onTap: () {
                                        controller.suffixIconEnabled = false;

                                        controller.licencePlateController
                                            .clear();
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
                      );
                    }),
                24.verticalSpace,
                Container(
                  height: 87.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xffb8d8e8).withOpacity(0.48),
                      borderRadius: BorderRadius.circular(5.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 156.w,
                        child: Text(
                          'didntfind',
                          style: TextStyle(
                              color: const Color(0xff030303),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ).tr(),
                      ),
                      GetBuilder<AddCarController>(
                          init: AddCarController(),
                          builder: (controller) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(26.r))),
                              onPressed: () {
                                Get.to(() => const AddManuallyScreen(),
                                    transition: Transition.rightToLeftWithFade,
                                    arguments: controller.user,
                                    duration: const Duration(milliseconds: 600));
                              },
                              child: Text(
                                'addmanually',
                                style: TextStyle(
                                    color: const Color(0xff030303),
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ).tr(),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
