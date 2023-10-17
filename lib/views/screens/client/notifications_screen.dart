import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:washly/controllers/client/addresses_list_controller.dart';
import 'package:washly/controllers/client/choose_address_controller.dart';
import 'package:washly/utils/buttons.dart';
import 'package:washly/utils/models/address.dart';
import 'package:washly/views/screens/client/add_address_screen.dart';
import 'package:washly/views/screens/client/notification_inside_screen.dart';

import '../../../utils/constants.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeaeff0),
      body: SingleChildScrollView(
        child: GetBuilder<AddressesListController>(
            init: AddressesListController(),
            builder: (controller) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    85.verticalSpace,
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
                      Text('Notifications',
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xff030303)))
                          .tr()
                    ]),
                    28.verticalSpace,
                    GetBuilder<AddressesListController>(
                        init: AddressesListController(),
                        builder: (controller) {
                          return controller.isLoading.value
                              ? const Center(child: Text('loading ...'))
                              : Container(
                                  child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            Column(
                                      children: [
                                        Center(
                                            child: InkWell(
                                          onTap: () {
                                            Get.to(() => NotificationInside());
                                            ///////
                                            // controller.addressSelectedMap[
                                            //         "address_name"] =
                                            //     controller
                                            //         .user.addresses!.reversed
                                            //         .toList()[index]
                                            //         .name!;
                                            // controller.addressSelectedMap[
                                            //         "address_description"] =
                                            //     controller
                                            //         .user.addresses!.reversed
                                            //         .toList()[index]
                                            //         .description!;
                                            // ///////

                                            // controller.selectedAddress =
                                            //     controller
                                            //         .user.addresses![index];
                                            // controller.update();
                                          },
                                          child: Container(
                                            height: 120.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: controller
                                                                .selectedAddress ==
                                                            controller.user
                                                                    .addresses![
                                                                index]
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
                                                  28.horizontalSpace,
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Tue, April 25, 2023 . 17:30",
                                                            style: TextStyle(
                                                                fontSize: 16.sp,
                                                                color:
                                                                    darkColor2,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          80.horizontalSpace,
                                                          // controller
                                                          //         .user
                                                          //         .addresses!
                                                          //         .reversed
                                                          //         .toList()[
                                                          //             index]
                                                          //         .isDefault!
                                                          //     ? Container(
                                                          //         width: 106.w,
                                                          //         height: 20.h,
                                                          //         decoration: BoxDecoration(
                                                          //             color:
                                                          //                 primaryColor,
                                                          //             borderRadius:
                                                          //                 BorderRadius.circular(
                                                          //                     9.r)),
                                                          //         child: Center(
                                                          //           child: Text(
                                                          //             "defaultaddress",
                                                          //             style: TextStyle(
                                                          //                 fontSize: 10
                                                          //                     .sp,
                                                          //                 color: Colors
                                                          //                     .white,
                                                          //                 fontWeight:
                                                          //                     FontWeight.bold),
                                                          //           ).tr(),
                                                          //         ))
                                                          //     : Container(),
                                                        ],
                                                      ),
                                                      5.verticalSpace,
                                                      SizedBox(
                                                        width: 250.w,
                                                        child: Text(
                                                          "",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontSize: 15.sp,
                                                              color: titleColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                      5.verticalSpace,
                                                      SizedBox(
                                                        width: 250.w,
                                                        child: Text(
                                                          "Mercedes-Benz | 57631 8",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontSize: 15.sp,
                                                              color: titleColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                      5.verticalSpace,
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  // Transform.scale(
                                                  //   scale: 1.5,
                                                  //   child: Padding(
                                                  //     padding:
                                                  //         const EdgeInsets.all(
                                                  //             0),
                                                  //     child: Radio<Address>(
                                                  //         fillColor: MaterialStateColor
                                                  //             .resolveWith((states) => controller
                                                  //                         .selectedAddress ==
                                                  //                     controller
                                                  //                             .user
                                                  //                             .addresses![
                                                  //                         index]
                                                  //                 ? primaryColor
                                                  //                 : const Color(
                                                  //                     0xff698695)),
                                                  //         activeColor:
                                                  //             Colors.white,
                                                  //         value: controller.user
                                                  //                 .addresses![
                                                  //             index],
                                                  //         groupValue: controller
                                                  //             .selectedAddress,
                                                  //         onChanged: (value) {
                                                  //           controller
                                                  //                   .selectedAddress =
                                                  //               value!;
                                                  //           // controller.verify();
                                                  //           controller.update();
                                                  //         }),
                                                  //   ),
                                                  // ),
                                                  4.horizontalSpace,
                                                ],
                                              ),
                                            ),
                                          ),
                                        )),
                                        index !=
                                                controller.user.addresses!
                                                        .length -
                                                    1
                                            ? Container()
                                            : 80.verticalSpace,
                                      ],
                                    ),
                                    itemCount:
                                        controller.user.addresses!.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            10.verticalSpace,
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
