// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:washly/controllers/client/appoitment_controller.dart';
import 'package:washly/controllers/client/checkout_controller.dart';
import 'package:washly/controllers/client/home_controller.dart';
import 'package:washly/controllers/client/main_controller.dart';
import 'package:washly/controllers/client/pay_controller.dart';
import 'package:washly/utils/buttons.dart';
import 'package:washly/utils/constants.dart';
import 'package:washly/views/components/widgets.dart';
import 'package:washly/views/screens/client/add_funds_screen.dart';
import 'package:washly/views/screens/client/home_screen.dart';
import 'package:washly/views/screens/client/order_screen.dart';

class PayScreen extends StatelessWidget {
  const PayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cont = Get.put(CheckoutController());
    final contr = Get.put(MainController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        child: GetBuilder<PayController>(
            init: PayController(),
            builder: (controller) {
              return Column(
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
                    Text('checkout',
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff030303)))
                        .tr()
                  ]),
                  27.verticalSpace,
                  Text('payementmethods',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff8aa7b7)))
                      .tr(),
                  18.3.verticalSpace,
                  Container(
                    height: 1,
                    width: 1.sw,
                    color: const Color(0xff698695).withOpacity(0.2),
                  ),
                  21.verticalSpace,
                  // InkWell(
                  //   onTap: () {
                  //     controller.payementWay = PayementWay.wallet;
                  //     controller.verify();
                  //     controller.update();
                  //   },
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Transform.scale(
                  //         scale: 1.5,
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(0),
                  //           child: Radio<PayementWay>(
                  //               fillColor: MaterialStateColor.resolveWith(
                  //                   (states) => controller.payementWay ==
                  //                           PayementWay.wallet
                  //                       ? primaryColor
                  //                       : const Color(0xff698695)),
                  //               activeColor: Colors.white,
                  //               value: PayementWay.wallet,
                  //               groupValue: controller.payementWay,
                  //               onChanged: (value) {
                  //                 controller.payementWay = value!;
                  //                 controller.verify();
                  //                 controller.update();
                  //               }),
                  //         ),
                  //       ),
                  //       15.horizontalSpace,
                  //       Column(
                  //         children: [
                  //           Text(
                  //             'wallet',
                  //             style: TextStyle(
                  //                 fontSize: 16.sp,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: const Color(0xff030303)),
                  //           ).tr(),
                  //           5.verticalSpace,
                  //           Text(
                  //             '0 MAD',
                  //             style: TextStyle(
                  //                 fontSize: 13.sp,
                  //                 fontWeight: FontWeight.w500,
                  //                 color: const Color(0xff698695)),
                  //           ).tr()
                  //         ],
                  //       ),
                  //       const Spacer(),
                  //       InkWell(
                  //         onTap: () => Get.to(() => AddFundsScreeen()),
                  //         child: Text(
                  //           "addfunds",
                  //           style: TextStyle(
                  //               fontSize: 15.sp,
                  //               fontWeight: FontWeight.w600,
                  //               color: primaryColor),
                  //         ).tr(),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // 22.verticalSpace,
                  // Container(
                  //   height: 1,
                  //   width: 1.sw,
                  //   color: const Color(0xff698695).withOpacity(0.2),
                  // ),
                  // 21.verticalSpace,
                  // InkWell(
                  //   onTap: () {
                  //     controller.payementWay = PayementWay.creditcard;
                  //     controller.verify();
                  //     controller.update();
                  //   },
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Transform.scale(
                  //         scale: 1.5,
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(0),
                  //           child: Radio<PayementWay>(
                  //               fillColor: MaterialStateColor.resolveWith(
                  //                   (states) => controller.payementWay ==
                  //                           PayementWay.creditcard
                  //                       ? primaryColor
                  //                       : const Color(0xff698695)),
                  //               activeColor: Colors.white,
                  //               value: PayementWay.creditcard,
                  //               groupValue: controller.payementWay,
                  //               onChanged: (value) {
                  //                 controller.payementWay = value!;
                  //                 controller.verify();
                  //                 controller.update();
                  //               }),
                  //         ),
                  //       ),
                  //       15.horizontalSpace,
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             'Credit Card (get 5% off)',
                  //             style: TextStyle(
                  //                 fontSize: 16.sp,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: const Color(0xff030303)),
                  //           ).tr(),
                  //           5.verticalSpace,
                  //           Text(
                  //             '**** 6589',
                  //             style: TextStyle(
                  //                 fontSize: 13.sp,
                  //                 fontWeight: FontWeight.w500,
                  //                 color: const Color(0xff698695)),
                  //           ).tr()
                  //         ],
                  //       ),
                  //       const Spacer(),
                  //       Text(
                  //         "edit",
                  //         style: TextStyle(
                  //             fontSize: 15.sp,
                  //             fontWeight: FontWeight.w600,
                  //             color: primaryColor),
                  //       ).tr()
                  //     ],
                  //   ),
                  // ),
                  
                  
                  InkWell(
                      onTap: () {
                        controller.payementWay = PayementWay.cash;
                        controller.verify();
                        controller.update();
                      },
                      child: 
                          Column(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Transform.scale(
                                    scale: 1.5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Radio<PayementWay>(
                                          fillColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) =>
                                                      controller.payementWay ==
                                                              PayementWay.cash
                                                          ? primaryColor
                                                          : const Color(
                                                              0xff698695)),
                                          activeColor: Colors.white,
                                          value: PayementWay.cash,
                                          groupValue: controller.payementWay,
                                          onChanged: (value) {
                                            controller.payementWay = value!;
                                            controller.verify();
                                            controller.update();
                                          }),
                                    ),
                                  ),
                                  15.horizontalSpace,
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'cash',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xff030303)),
                                        ).tr(),
                                        5.verticalSpace,
                                        Text(
                                          'beinperson',
                                          // overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xff698695)),
                                        ).tr(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              21.verticalSpace,
                              Container(
                                height: 1,
                                width: 1.sw,
                                color: const Color(0xff698695).withOpacity(0.2),
                              ),
                            ])
                          ),
                  22.verticalSpace,
                  contr.washType != WashType.basic
                      ? Row(children: [
                          GetBuilder<PayController>(
                              // init: PayController(),
                              builder: (cont) => Transform.scale(
                                    scale: 1.5,
                                    child: Checkbox(
                                        activeColor: Color(0xFF43e293),
                                        value: cont.checkBoxValue,
                                        onChanged: ((value) {
                                          cont.checkBoxValue = value!;
                                          cont.verify();
                                          cont.update();
                                        })),
                                  )),
                          Flexible(
                            child: Text(
                              "I don't have anything valuable in my car",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xff030303)),
                            ),
                          ),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ])
                      : Container(),
                  27.verticalSpace,
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                      width: 383.h,
                      height: 76.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 21, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Color.fromARGB(255, 242, 229, 209),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/images/Group-514.svg",
                            height: 32.h,
                            width: 29.w,
                          ),
                          14.horizontalSpace,
                          Expanded(
                              child: Text(
                            "We do nt take any responsibilites for the loss or theft of belongings left in the car",
                            style: TextStyle(
                                height: 1.5,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xffff8d41)),
                          ))
                        ],
                      ),
                    ),
                  ]),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'discount',
                        style: TextStyle(
                          color: const Color(0xff698695),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ).tr(),
                      Text(
                        '0 MAD',
                        style: TextStyle(
                          color: const Color(0xff698695),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ).tr(),
                    ],
                  ),
                  8.verticalSpace,
                  GetBuilder<MainController>(
                    init: MainController(),
                    builder: (cont) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'subtotal',
                          style: TextStyle(
                            color: const Color(0xff698695),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ).tr(),
                        Text(
                          '${cont.priceWash()} MAD',
                          style: TextStyle(
                            color: const Color(0xff698695),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ).tr(),
                      ],
                    ),
                  ),
                  8.verticalSpace,
                  GetBuilder<MainController>(
                    builder: (cont) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'totaltopay',
                          style: TextStyle(
                            color: const Color(0xff030303),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ).tr(),
                        Text(
                          '${cont.priceWash()} MAD',
                          style: TextStyle(
                            color: const Color(0xff030303),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ).tr(),
                      ],
                    ),
                  ),
                  29.verticalSpace,
                  GradientButton(
                    allowed: controller.allowed,
                    text: 'Confirm',
                    onpress: () async {
                      //redirect to orderScreen
                      if (cont.isToday && cont.hourSelected == "Wash now") {
                        showPayementStatusDialog(
                            context: Get.context!,
                            allowBackNavigation: true,
                            status: true);
                        Get.back();
                        Get.to(
                          () => const OrderScreen(),
                          transition: Transition.rightToLeft,
                          duration: 500.milliseconds,
                        );
                      } else {
                        //Store appointement

                        final controller = Get.put(AppointementController());
                        controller.confirm();
                      }

                      // controller.pay();
                    },
                  ),
                  41.verticalSpace,
                ],
              );
            }),
      ),
    );
  }
}
