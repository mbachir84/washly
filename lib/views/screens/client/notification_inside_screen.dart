// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:washly/utils/buttons.dart';

class NotificationInside extends StatelessWidget {
  const NotificationInside({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(vertical: 38.h, horizontal: 24.w),
          child: GradientButton(
            text: 'Contact Washer',
            onpress: () {
              // Get.to(
              //   () => const AddFundsScreeen(),
              //   duration: const Duration(milliseconds: 500),
              //   transition: Transition.rightToLeftWithFade,
              // );
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
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
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff030303)))
                            .tr()
                      ]),
                      3.verticalSpace,
                      Row(children: [
                        37.horizontalSpace,
                        Text(
                          "All set! Your car is ready!",
                          style: TextStyle(
                              fontSize: 16.sp, color: Color(0xfff698695)),
                        ),
                      ]),
                      10.verticalSpace,
                      Container(
                        height: 118.h,
                        width: 382.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.11),
                              offset: Offset(0,
                                  9), // (0, 9) corresponds to the x and y offset
                              blurRadius: 33,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                  width: 83.w,
                                  height: 88.h,
                                  color: Colors.black),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Mercedes-Benz"),
                                Text("GLC Coupe"),
                                Text("57631 | 8"),
                              ],
                            )
                          ],
                        ),
                      ),
                      28.verticalSpace,
                      Text("Wash"),
                      5.verticalSpace,
                      Text("Basic Wash"),
                      13.verticalSpace,
                      Divider(
                        thickness: 1,
                      ),
                      13.verticalSpace,
                      Text("Location"),
                      5.verticalSpace,
                      Text("Home"),
                      13.verticalSpace,
                      Divider(thickness: 1,),
                      13.verticalSpace,
                      Text("Payment methode"),
                      5.verticalSpace,
                      Text("Wallet"),
                      13.verticalSpace,
                      Divider(thickness: 1,),
                      13.verticalSpace,
                      Text("Price"),
                      5.verticalSpace,
                      Text("20 MAD"),
                      13.verticalSpace,
                      Divider(thickness: 1,),
                      13.verticalSpace,
                      Text("Discount"),
                      5.verticalSpace,
                      Text("1 MAD "),
                      13.verticalSpace,
                      Divider(thickness: 1,),
                      13.verticalSpace,
                      Text("Washer"),
                      5.verticalSpace,
                      Text("Khalid Bennani"),
                      13.verticalSpace,
                      Divider(thickness: 1,),


                    ]))));
  }
}
