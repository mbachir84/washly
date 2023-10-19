import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:washly/controllers/client/pay_controller.dart';
import 'package:washly/utils/buttons.dart';
import 'package:washly/utils/constants.dart';
import 'package:washly/views/components/widgets.dart';

class PayScreen extends StatelessWidget {
  const PayScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  InkWell(
                    onTap: () {
                      controller.payementWay = PayementWay.wallet;
                      controller.verify();
                      controller.update();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Radio<PayementWay>(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => controller.payementWay ==
                                            PayementWay.wallet
                                        ? primaryColor
                                        : const Color(0xff698695)),
                                activeColor: Colors.white,
                                value: PayementWay.wallet,
                                groupValue: controller.payementWay,
                                onChanged: (value) {
                                  controller.payementWay = value!;
                                  controller.verify();
                                  controller.update();
                                }),
                          ),
                        ),
                        15.horizontalSpace,
                        Column(
                          children: [
                            Text(
                              'wallet',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff030303)),
                            ).tr(),
                            5.verticalSpace,
                            Text(
                              '0 MAD',
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff698695)),
                            ).tr()
                          ],
                        ),
                        const Spacer(),
                        Text(
                          "addfunds",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: primaryColor),
                        ).tr()
                      ],
                    ),
                  ),
                  22.verticalSpace,
                  Container(
                    height: 1,
                    width: 1.sw,
                    color: const Color(0xff698695).withOpacity(0.2),
                  ),
                  21.verticalSpace,
                  InkWell(
                    onTap: () {
                      controller.payementWay = PayementWay.creditcard;
                      controller.verify();
                      controller.update();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Radio<PayementWay>(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => controller.payementWay ==
                                            PayementWay.creditcard
                                        ? primaryColor
                                        : const Color(0xff698695)),
                                activeColor: Colors.white,
                                value: PayementWay.creditcard,
                                groupValue: controller.payementWay,
                                onChanged: (value) {
                                  controller.payementWay = value!;
                                  controller.verify();
                                  controller.update();
                                }),
                          ),
                        ),
                        15.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Credit Card (get 5% off)',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff030303)),
                            ).tr(),
                            5.verticalSpace,
                            Text(
                              '**** 6589',
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff698695)),
                            ).tr()
                          ],
                        ),
                        const Spacer(),
                        Text(
                          "edit",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: primaryColor),
                        ).tr()
                      ],
                    ),
                  ),
                  23.verticalSpace,
                  Container(
                    height: 1,
                    width: 1.sw,
                    color: const Color(0xff698695).withOpacity(0.2),
                  ),
                  21.verticalSpace,
                  InkWell(
                    onTap: () {
                      controller.payementWay = PayementWay.cash;
                      controller.verify();
                      controller.update();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Radio<PayementWay>(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => controller.payementWay ==
                                            PayementWay.cash
                                        ? primaryColor
                                        : const Color(0xff698695)),
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
                        Flexible (
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                  ),
                  21.verticalSpace,
                  Container(
                    height: 1,
                    width: 1.sw,
                    color: const Color(0xff698695).withOpacity(0.2),
                  ),
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
                  Row(
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
                        '20 MAD',
                        style: TextStyle(
                          color: const Color(0xff698695),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ).tr(),
                    ],
                  ),
                  8.verticalSpace,
                  Row(
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
                        '20 MAD',
                        style: TextStyle(
                          color: const Color(0xff030303),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ).tr(),
                    ],
                  ),
                  29.verticalSpace,
                  GradientButton(
                    allowed: controller.allowed,
                    text: 'paynow',
                    onpress: () {
                      showPayementStatusDialog(
                          context: Get.context!,
                          allowBackNavigation: true,
                          status: false);

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
