import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:washly/controllers/client/choose_car_controller.dart';
import 'package:washly/views/screens/client/add_car_screen.dart';

import '../../../utils/buttons.dart';
import '../../../utils/constants.dart';
import '../../../utils/models/w_user.dart';

class ChooseCarScreen extends StatelessWidget {
  const ChooseCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(vertical: 41.h, horizontal: 24.w),
        child: GetBuilder<ChooseCarController>(
            init: ChooseCarController(),
            builder: (controller) {
              return GradientButton(
                text: 'addcar',
                onpress: () {
                  Get.to(
                    () => const AddCarScreen(),
                    arguments: [controller.user],
                    transition: Transition.rightToLeftWithFade,
                    duration: const Duration(milliseconds: 500),
                  );

                  // controller.verify();
                },
              );
            }),
      ),
      backgroundColor: const Color(0xffeaeff0),
      body: SingleChildScrollView(
        child: GetBuilder<ChooseCarController>(
            init: ChooseCarController(),
            builder: (controller) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    80.verticalSpace,
                    Row(children: [
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child: SvgPicture.asset(
                                  'assets/images/arrow-back.svg'))),
                      16.horizontalSpace,
                      Text('selectcar',
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xff030303)))
                          .tr()
                    ]),
                    28.verticalSpace,
                    GetBuilder<ChooseCarController>(
                        init: ChooseCarController(),
                        builder: (controller) {
                          return controller.isLoading.value
                              ? const Center(child: Text('loading ...'))
                              : Center(
                                  child: SizedBox(
                                    height: 1.sh,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              Column(                              
                                        children: [
                                          Center(
                                              child: InkWell(
                                            onTap: () {
                                              controller.selectedCar =
                                                  controller.user.cars[index];
                                                  
                                              controller.user.cars[index]
                                                  .isSelected = true;
                                              controller.update();
                                            },
                                            child: Container(
                                              height: 118.h,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: controller
                                                                  .selectedCar ==
                                                              controller.user
                                                                  .cars[index]
                                                          ? primaryColor
                                                          : Colors.transparent,
                                                      width: 2.w),
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15.0.w),
                                                child: Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9.r),
                                                      child: CachedNetworkImage(
                                                        imageUrl: controller
                                                            .user
                                                            .cars[index]
                                                            .image!,
                                                        height: 83.h,
                                                        width: 83.w,
                                                        fit: BoxFit.cover,
                                                        placeholder: (context,
                                                                url) =>
                                                            const Center(
                                                                child:
                                                                    CircularProgressIndicator()),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      ),
                                                    ),
                                                    16.horizontalSpace,
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          controller
                                                              .user
                                                              .cars[index]
                                                              .make!,
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              color: darkColor2,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        5.verticalSpace,
                                                        Text(
                                                          controller
                                                              .user
                                                              .cars[index]
                                                              .model!,
                                                          style: TextStyle(
                                                              fontSize: 15.sp,
                                                              color: titleColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        5.verticalSpace,
                                                        Text(
                                                          controller
                                                              .user
                                                              .cars[index]
                                                              .licencePlate!,
                                                          style: TextStyle(
                                                            fontSize: 13.sp,
                                                            color: titleColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Transform.scale(
                                                      scale: 1.5,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Radio<Car>(
                                                            fillColor: MaterialStateColor.resolveWith((states) => controller
                                                                        .selectedCar ==
                                                                    controller
                                                                            .user
                                                                            .cars[
                                                                        index]
                                                                ? primaryColor
                                                                : const Color(
                                                                    0xff698695)),
                                                            activeColor:
                                                                Colors.white,
                                                            value: controller
                                                                .user
                                                                .cars[index],
                                                            groupValue:
                                                                controller
                                                                    .selectedCar,
                                                            onChanged: (value) {
                                                              controller
                                                                      .selectedCar =
                                                                  value!;
                                                              // controller.verify();
                                                              controller
                                                                  .update();
                                                            }),
                                                      ),
                                                    ),
                                                    4.horizontalSpace,
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                          index !=
                                                  controller.user.cars.length -
                                                      1
                                              ? 0.verticalSpace
                                              : 300.verticalSpace,
                                        ],
                                      ),
                                      itemCount: controller.user.cars.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              10.verticalSpace,
                                    ),
                                  ),
                                );
                        }),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
