// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:washly/utils/constants.dart';

class AddCreditCard extends StatelessWidget {
  const AddCreditCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAEFF0),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            85.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                  Text('Add Credit Card',
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: darkColor))
                      .tr()
                ]),
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      "Canccel",
                      style:
                          TextStyle(fontSize: 16.sp, color: Color(0xff10a7f5)),
                    ))
              ],
            ),
            42.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Card Number",
                    style: TextStyle(fontSize: 16.sp, color: Color(0xff698695)),
                  ),
                  12.verticalSpace,
                  TextField(),
                  43.verticalSpace,
                  Text(
                    "Cardholder Name",
                    style: TextStyle(fontSize: 16.sp, color: Color(0xff698695)),
                  ),
                  12.verticalSpace,
                  TextField(),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
