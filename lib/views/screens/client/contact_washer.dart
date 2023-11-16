import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:washly/utils/buttons.dart';

class ContactWasherScreen extends StatelessWidget {
  const ContactWasherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 24.0.h, right: 24.0.h, bottom: 12.0.h),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GradientButton(
                colors: const [
                  Color(0xff698695),
                  Color(0xffa7c5d6),
                ],
                text: "Send Request",
                onpress: () {},
              ),
              10.verticalSpace,
              GradientButton(
                text: 'Close',
                onpress: () {
                  //getreceipt(context: context);
                },
              ),
            ]),
      ),
      body: Padding(
        padding:EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            85.verticalSpace,
            Row(
              children: [
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
                  Text('Contact Washer',
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff030303)))
                      .tr()
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }
}
