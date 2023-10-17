// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:washly/utils/constants.dart';
import 'package:washly/views/screens/client/add_funds_credit_card.dart';

class AddFundsScreeen extends StatelessWidget {
  const AddFundsScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAEFF0),
      body: SingleChildScrollView(
        child: Padding(
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
                        child:
                            SvgPicture.asset('assets/images/arrow-back.svg'))),
                16.horizontalSpace,
                Text('Add Funds',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: darkColor))
                    .tr()
              ]),
              25.verticalSpace,
              Text(
                "Select charge methode",
                style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: darkColor),
              ),
              22.verticalSpace,
              InkWell(
                onTap: () {
                  Get.to(() => AddFundsCreditCard());
                },
                child: Container(
                  width: 382.w,
                  height: 97.h,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(71, 96, 108, 0.1),
                          offset: Offset(
                              0, 8), // (0, 8) corresponds to the x and y offset
                          blurRadius: 16,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                                'assets/images/credit-card-icon.svg'),
                            20.horizontalSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Credit Card",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold)),
                                5.verticalSpace,
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/mastercard.svg'),
                                    Text(
                                      "  ***5488",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Color(0xfff698695)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios,
                              color: const Color(0xff313131),
                              size: 16.sp,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              17.verticalSpace,
              InkWell(
                onTap: () {},
                child: Container(
                  width: 382.w,
                  height: 97.h,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(71, 96, 108, 0.1),
                          offset: Offset(
                              0, 8), // (0, 8) corresponds to the x and y offset
                          blurRadius: 16,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/images/money-icon.svg'),
                            20.horizontalSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Pay Express",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                5.verticalSpace,
                                Text(
                                  "Wafacash,Cashplus,",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Color(0xfff698695),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios,
                              color: const Color(0xff313131),
                              size: 16.sp,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
