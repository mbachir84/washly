// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, deprecated_member_use, unnecessary_import

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:washly/utils/buttons.dart';
import 'package:washly/utils/constants.dart';
import 'package:washly/views/screens/client/add_funds_screen.dart';

class AddFundsCreditCard extends StatelessWidget {
  const AddFundsCreditCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(vertical: 41.h, horizontal: 24.w),
        child: GradientButton(
          text: '+ Add funds',
          onpress: () {
            Get.to(
              () => const AddFundsScreeen(),
              duration: const Duration(milliseconds: 500),
              transition: Transition.rightToLeftWithFade,
            );
          },
        ),
      ),
      backgroundColor: Color(0xfffeaeff0),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(children: [
          Stack(
            children: [
              Container(
                height: 320.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  gradient: const LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [
                        Color(0xfff4cf166),
                        Color(0xfff20b1ee),
                      ]),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                                  'assets/images/arrow-back.svg',
                                  color: Colors.white,
                                ),
                              )),
                          16.horizontalSpace,
                          Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                16.verticalSpace,
                                Text('Add Funds',
                                    style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white)),
                                Text(
                                  "By Credit Card",
                                  style: TextStyle(
                                      fontSize: 16.sp, color: Colors.white),
                                )
                              ]),
                        ],
                      ),
                      32.verticalSpace,
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      "0",
                                      style: TextStyle(
                                          fontSize: 77.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ]),
                            Text(
                              "MAD",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ])
                    ],
                  ),
                ),
              ),
            ],
          ),
          25.verticalSpace,
          Container(
            width: 382.w,
            height: 97.h,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(71, 96, 108, 0.1),
                offset:
                    Offset(0, 8), // (0, 8) corresponds to the x and y offset
                blurRadius: 16,
              ),
            ], color: Colors.white, borderRadius: BorderRadius.circular(9)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/credit-card-icon.svg'),
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
                              SvgPicture.asset('assets/images/mastercard.svg'),
                              Text(
                                "  ***5488",
                                style: TextStyle(
                                    fontSize: 15.sp, color: Color(0xfff698695)),
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
        ]),
      ),
    );
  }
}
