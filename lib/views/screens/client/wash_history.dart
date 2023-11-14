import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:washly/controllers/client/appoitment_controller.dart';
import 'package:washly/utils/buttons.dart';
import 'package:washly/utils/constants.dart';
import 'package:washly/views/components/widgets.dart';
import 'package:washly/views/screens/client/wash_details.dart';

class WashHistoryScreen extends StatelessWidget {
  const WashHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<AppointementController>(
            init: AppointementController(),
            builder: (controller) {
              return WillPopScope(
                onWillPop: () async {
                  controller.appointmentShow = false;
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
                          Row(
                            children: [
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
                              Text(
                                'Wash History',
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          28.verticalSpace,
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
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (BuildContext context,
                                                    int index) =>
                                                Center(
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      controller
                                                              .appointmentShow =
                                                          true;
                                                      Get.to(
                                                          () =>
                                                              const WashDetailsScreen(),
                                                          transition:
                                                              Transition.fadeIn,
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      500));
                                                      controller.update();
                                                    },
                                                    child: AppointmentWidget(
                                                        title: index == 1
                                                            ? "Full Wash"
                                                            : "basicwash",
                                                        status: true),
                                                  ),
                                                  index !=
                                                          controller
                                                              .user.cars.length
                                                      ? const SizedBox()
                                                      : 250.verticalSpace,
                                                ],
                                              ),
                                            ),
                                            itemCount: 3,
                                            separatorBuilder:
                                                (BuildContext context,
                                                        int index) =>
                                                    17.verticalSpace,
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
              );
              // : WillPopScope(
              //     onWillPop: () async {
              //       controller.appointmentShow = true;
              //       controller.update();
              //       return false;
              //     },
              //     child: Container(
              //       width: double.infinity,
              //       color: Colors.white,
              //       constraints: BoxConstraints(
              //         minHeight: 1.sh - 200,
              //       ),
              //       child: Padding(
              //         padding: EdgeInsets.symmetric(horizontal: 24.0.w),
              //         child: Column(
              //           children: [
              //             85.verticalSpace,
              //             Row(
              //               children: [
              //                 Padding(
              //                   padding: const EdgeInsets.all(0),
              //                   child: IconButton(
              //                       padding: EdgeInsets.zero,
              //                       onPressed: () {
              //                         controller.appointmentShow = false;
              //                         controller.update();
              //                       },
              //                       icon: SvgPicture.asset(
              //                         'assets/images/arrow-back.svg',
              //                         height: 9.h,
              //                         width: 17,
              //                       )),
              //                 ),
              //                 0.horizontalSpace,
              //                 Text(
              //                   'appointmentdetails',
              //                   style: TextStyle(
              //                     fontSize: 22.sp,
              //                     color: const Color(0xff030303),
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ).tr(),
              //               ],
              //             ),
              //             20.verticalSpace,
              //             Container(
              //               width: double.infinity,
              //               height: 1,
              //               color: const Color(0xff698695).withOpacity(0.2),
              //             ),
              //             18.verticalSpace,
              //             Row(
              //               children: [
              //                 SvgPicture.asset(
              //                     'assets/images/wash-icon.svg'),
              //                 14.horizontalSpace,
              //                 Text('basicwash',
              //                     style: TextStyle(
              //                       fontSize: 16.sp,
              //                       fontWeight: FontWeight.bold,
              //                       color: const Color(0xff030303),
              //                     )).tr(),
              //                 15.horizontalSpace,
              //                 InkWell(
              //                   onTap: () {
              //                     controller.infoClick();
              //                   },
              //                   child: Container(
              //                     height: 35.w,
              //                     width: 35.w,
              //                     decoration: BoxDecoration(
              //                         color: const Color(0xff10a7f5)
              //                             .withOpacity(0.07),
              //                         borderRadius:
              //                             BorderRadius.circular(5.r)),
              //                     child: Icon(
              //                       Icons.info_outline,
              //                       size: 20.sp,
              //                       color: primaryColor,
              //                     ),
              //                   ),
              //                 ),
              //                 const Spacer(),
              //                 Text('20 MAD',
              //                         style: TextStyle(
              //                             fontSize: 16.sp,
              //                             fontWeight: FontWeight.bold,
              //                             color: const Color(0xff030303)))
              //                     .tr(),
              //               ],
              //             ),
              //             18.verticalSpace,
              //             Container(
              //               width: double.infinity,
              //               height: 1,
              //               color: const Color(0xff698695).withOpacity(0.2),
              //             ),
              //             18.5.verticalSpace,
              //             Row(
              //               children: [
              //                 SvgPicture.asset(
              //                     'assets/images/car-select-icon.svg'),
              //                 14.horizontalSpace,
              //                 Column(
              //                   crossAxisAlignment:
              //                       CrossAxisAlignment.start,
              //                   children: [
              //                     Text('Mercedes-Benz',
              //                         style: TextStyle(
              //                           fontSize: 16.sp,
              //                           fontWeight: FontWeight.bold,
              //                           color: const Color(0xff030303),
              //                         )).tr(),
              //                     Text('57631 | 8',
              //                         style: TextStyle(
              //                           fontSize: 13.sp,
              //                           fontWeight: FontWeight.bold,
              //                           color: const Color(0xff698695),
              //                         )).tr(),
              //                   ],
              //                 ),
              //                 const Spacer(),
              //                 Icon(
              //                   Icons.arrow_forward_ios,
              //                   color: const Color(0xff313131),
              //                   size: 16.sp,
              //                 ),
              //               ],
              //             ),
              //             18.5.verticalSpace,
              //             Container(
              //               height: 1,
              //               width: 1.sw,
              //               color: const Color(0xff698695).withOpacity(0.2),
              //             ),
              //             18.5.verticalSpace,
              //             Row(
              //               children: [
              //                 SvgPicture.asset(
              //                     'assets/images/location-select-icon.svg'),
              //                 14.horizontalSpace,
              //                 Column(
              //                   crossAxisAlignment:
              //                       CrossAxisAlignment.start,
              //                   children: [
              //                     Text('Home',
              //                         style: TextStyle(
              //                           fontSize: 16.sp,
              //                           fontWeight: FontWeight.bold,
              //                           color: const Color(0xff030303),
              //                         )).tr(),
              //                     Text('Rez de, 443 Bd Al Hassan Al Alaoui',
              //                         style: TextStyle(
              //                           fontSize: 13.sp,
              //                           fontWeight: FontWeight.bold,
              //                           color: const Color(0xff698695),
              //                         )).tr(),
              //                   ],
              //                 ),
              //                 const Spacer(),
              //                 Icon(
              //                   Icons.arrow_forward_ios,
              //                   color: const Color(0xff313131),
              //                   size: 16.sp,
              //                 ),
              //               ],
              //             ),
              //             18.5.verticalSpace,
              //             Container(
              //               height: 1,
              //               width: 1.sw,
              //               color: const Color(0xff698695).withOpacity(0.2),
              //             ),
              //             18.5.verticalSpace,
              //             Row(
              //               children: [
              //                 SvgPicture.asset(
              //                     'assets/images/booking-select-icon.svg'),
              //                 14.horizontalSpace,
              //                 Column(
              //                   crossAxisAlignment:
              //                       CrossAxisAlignment.start,
              //                   children: [
              //                     Text('April 24, 2023',
              //                         style: TextStyle(
              //                           fontSize: 16.sp,
              //                           fontWeight: FontWeight.bold,
              //                           color: const Color(0xff030303),
              //                         )).tr(),
              //                     Text('Wash Now',
              //                         style: TextStyle(
              //                           fontSize: 13.sp,
              //                           fontWeight: FontWeight.bold,
              //                           color: const Color(0xff698695),
              //                         )).tr(),
              //                   ],
              //                 ),
              //                 const Spacer(),
              //                 Icon(
              //                   Icons.arrow_forward_ios,
              //                   color: const Color(0xff313131),
              //                   size: 16.sp,
              //                 ),
              //               ],
              //             ),
              //             18.5.verticalSpace,
              //             Container(
              //               height: 1,
              //               width: 1.sw,
              //               color: const Color(0xff698695).withOpacity(0.2),
              //             ),
              //             18.5.verticalSpace,
              //             Row(
              //               children: [
              //                 SvgPicture.asset(
              //                     'assets/images/wallet-select.svg'),
              //                 14.horizontalSpace,
              //                 Column(
              //                   crossAxisAlignment:
              //                       CrossAxisAlignment.start,
              //                   children: [
              //                     Text('Wallet',
              //                         style: TextStyle(
              //                           fontSize: 16.sp,
              //                           fontWeight: FontWeight.bold,
              //                           color: const Color(0xff030303),
              //                         )).tr(),
              //                     Row(
              //                       children: [
              //                         Container(
              //                             height: 9.h,
              //                             width: 9.h,
              //                             decoration: BoxDecoration(
              //                                 color: controller.paid
              //                                     ? const Color(0xff37d586)
              //                                     : const Color(0xffff4141),
              //                                 shape: BoxShape.circle)),
              //                         6.5.horizontalSpace,
              //                         Text(
              //                             controller.paid
              //                                 ? 'paid'
              //                                 : 'paymentdeclined',
              //                             style: TextStyle(
              //                               fontSize: 13.sp,
              //                               fontWeight: FontWeight.bold,
              //                               color: controller.paid
              //                                   ? const Color(0xff37d586)
              //                                   : const Color(0xffff4141),
              //                             )).tr(),
              //                       ],
              //                     ),
              //                   ],
              //                 ),
              //                 const Spacer(),
              //                 controller.paid
              //                     ? Container()
              //                     : Icon(
              //                         Icons.arrow_forward_ios,
              //                         color: const Color(0xff313131),
              //                         size: 16.sp,
              //                       ),
              //               ],
              //             ),
              //             18.5.verticalSpace,
              //             Container(
              //               height: 1,
              //               width: 1.sw,
              //               color: const Color(0xff698695).withOpacity(0.2),
              //             ),
              //             100.verticalSpace,
              //             // GradientButton(
              //             //   colors: [
              //             //     const Color(0xff698695),
              //             //     const Color(0xff698695).withOpacity(0.7),
              //             //   ],
              //             //   text: 'cancelappointment',
              //             //   onpress: () {
              //             //     showCancelAppointment(context: context);
              //             //   },
              //             // ),
              //             17.verticalSpace,
              //             Text('nomoney',
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(
              //                   fontSize: 13.sp,
              //                   fontWeight: FontWeight.w500,
              //                   color: const Color(0xff313131),
              //                 )).tr(),
              //             30.verticalSpace,
              //           ],
              //         ),
              //       ),
              //     ),
              //   );
            }),
      ),
    );
  }
}
