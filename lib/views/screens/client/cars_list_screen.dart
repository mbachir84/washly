import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:washly/utils/constants.dart';
import 'package:washly/views/components/widgets.dart';
import 'package:washly/views/screens/client/wash_details.dart';

import '../../../controllers/client/cars_list_controller.dart';
import 'edit_car_screen.dart';

class CarsListScreen extends StatelessWidget {
  const CarsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CarsListController>(
        init: CarsListController(),
        builder: (controller) {
          return !controller.carShow
              ? WillPopScope(
                  onWillPop: () async {
                    controller.carShow = false;
                    controller.update();
                    return false;
                  },
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            85.verticalSpace,
                            Text(
                              'yourcars',
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ).tr(),
                            20.verticalSpace,
                            controller.isLoading.value
                                ? Center(
                                    child: SpinKitDoubleBounce(
                                    color: primaryColor,
                                    size: 50.0.sp,
                                  ))
                                : Center(
                                    child: SizedBox(
                                      height: 1.sh - 100,
                                      child: controller.user.cars.isNotEmpty
                                          ? ListView.separated(
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      Center(
                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        controller.carShow =
                                                            true;
                                                        controller.selectedCar =
                                                            controller.user
                                                                .cars[index];
                                                        controller.update();
                                                      },
                                                      child: Container(
                                                        height: 118.h,
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r)),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 15.0.w,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            9.r),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: controller
                                                                      .user
                                                                      .cars[
                                                                          index]
                                                                      .image!,
                                                                  height: 83.h,
                                                                  width: 83.w,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      const Center(
                                                                          child:
                                                                              CircularProgressIndicator()),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Icon(Icons
                                                                          .error),
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
                                                                        .cars[
                                                                            index]
                                                                        .make!,
                                                                    style: TextStyle(
                                                                        fontSize: 16
                                                                            .sp,
                                                                        color:
                                                                            darkColor2,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  5.verticalSpace,
                                                                  Text(
                                                                    controller
                                                                        .user
                                                                        .cars[
                                                                            index]
                                                                        .model!,
                                                                    style: TextStyle(
                                                                        fontSize: 15
                                                                            .sp,
                                                                        color:
                                                                            titleColor,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  5.verticalSpace,
                                                                  Text(
                                                                    controller
                                                                        .user
                                                                        .cars[
                                                                            index]
                                                                        .licencePlate!,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.sp,
                                                                      color:
                                                                          titleColor,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const Spacer(),
                                                              Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                color: const Color(
                                                                    0xff313131),
                                                                size: 16.sp,
                                                              ),
                                                              4.horizontalSpace,
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    index !=
                                                            controller
                                                                    .user
                                                                    .cars.length -
                                                                1
                                                        ? const SizedBox()
                                                        : 250.verticalSpace,
                                                  ],
                                                ),
                                              ),
                                              itemCount:
                                                  controller.user.cars.length,
                                              separatorBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      10.verticalSpace,
                                            )
                                          : Container(),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      AnimatedSnackbar(
                          height: controller.height,
                          title: controller.snackBarTitle,
                          subtitle: controller.snackBarSubTitle,
                          state: controller.state),
                    ],
                  ),
                )
              : WillPopScope(
                  onWillPop: () async {
                    controller.carShow = false;
                    controller.update();
                    return false;
                  },
                  child: Container(
                    color: Colors.white,
                    constraints: BoxConstraints(
                      minHeight: 1.sh,
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              83.verticalSpace,
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        controller.carShow = false;
                                        controller.update();
                                      },
                                      icon: SvgPicture.asset(
                                        'assets/images/arrow-back.svg',
                                        height: 9.h,
                                        width: 17,
                                      )),
                                  16.horizontalSpace,
                                  Text(
                                    'yourcars',
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      color: const Color(0xff030303),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ).tr(),
                                  const Spacer(),
                                  TextButton(
                                      onPressed: () {
                                        // final EditCarController
                                        //     editCarController =
                                        //     Get.put(EditCarController());
                                        // editCarController.car =
                                        //     controller.selectedCar;
                                        // editCarController.makeController.text =
                                        //     controller.selectedCar.make!;
                                        // editCarController
                                        //         .licencePlateController.text =
                                        //     controller.selectedCar.licencePlate!;
                                        // editCarController.update();
                                        // editCarController.modelController.text =
                                        //     controller.selectedCar.model!;
                                        // editCarController.update();
                                        Get.to(
                                          () => const EditCarScreen(),
                                          transition: Transition.rightToLeft,
                                          arguments: controller.selectedCar,
                                        );
                                      },
                                      child: Text(
                                        'editcar',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ).tr())
                                ],
                              ),
                              27.verticalSpace,
                              ClipRRect(
                                borderRadius: BorderRadius.circular(9.r),
                                child: CachedNetworkImage(
                                  imageUrl: controller.selectedCar.image!,
                                  height: 200.h,
                                  width: double.infinity.w,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              26.verticalSpace,
                              Text(
                                'make',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: const Color(0xff698695),
                                  fontWeight: FontWeight.w500,
                                ),
                              ).tr(),
                              2.verticalSpace,
                              Text(
                                controller.selectedCar.make!,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color(0xff030303),
                                    fontWeight: FontWeight.bold),
                              ),
                              12.verticalSpace,
                              Container(
                                height: 1.h,
                                width: double.infinity.w,
                                color: const Color(0xff698695).withOpacity(0.2),
                              ),
                              12.verticalSpace,
                              Text(
                                'model',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: const Color(0xff698695),
                                  fontWeight: FontWeight.w500,
                                ),
                              ).tr(),
                              2.verticalSpace,
                              Text(
                                controller.selectedCar.model!,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color(0xff030303),
                                    fontWeight: FontWeight.bold),
                              ),
                              12.verticalSpace,
                              Container(
                                height: 1.h,
                                width: double.infinity.w,
                                color: const Color(0xff698695).withOpacity(0.2),
                              ),
                              12.verticalSpace,
                              Text(
                                'licenceplate',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: const Color(0xff698695),
                                  fontWeight: FontWeight.w500,
                                ),
                              ).tr(),
                              2.verticalSpace,
                              Text(
                                controller.selectedCar.licencePlate!,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color(0xff030303),
                                    fontWeight: FontWeight.bold),
                              ),
                              12.verticalSpace,
                              Container(
                                height: 1.h,
                                width: double.infinity.w,
                                color: const Color(0xff698695).withOpacity(0.2),
                              ),
                              52.verticalSpace,
                              Text(
                                'washhistory',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color(0xff698695),
                                  fontWeight: FontWeight.w500,
                                ),
                              ).tr(),
                              9.verticalSpace,
                              Container(
                                height: 1.h,
                                width: double.infinity.w,
                                color: const Color(0xff698695).withOpacity(0.2),
                              ),
                              9.verticalSpace,
                              ListView.separated(
                                padding: EdgeInsets.zero,
                                itemCount: 11,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () => Get.to(
                                    () => const WashDetailsScreen(),
                                    transition: Transition.rightToLeftWithFade,
                                    duration: const Duration(milliseconds: 500),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '4/7/2023 at 13:35',
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: const Color(0xff030303),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            'Home Location',
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                color: const Color(0xff698695),
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: const Color(0xff698695),
                                        size: 16.sp,
                                      ),
                                    ],
                                  ),
                                ),
                                separatorBuilder:
                                    (BuildContext context, int index) => Column(
                                  children: [
                                    9.verticalSpace,
                                    Container(
                                      height: 1.h,
                                      width: double.infinity.w,
                                      color: const Color(0xff698695).withOpacity(0.2),
                                    ),
                                    9.verticalSpace,
                                  ],
                                ),
                              ),
                              9.verticalSpace,
                              Container(
                                height: 1.h,
                                width: double.infinity.w,
                                color: const Color(0xff698695).withOpacity(0.2),
                              ),
                              100.verticalSpace,
                            ],
                          )),
                    ),
                  ),
                );
        });
  }
}
