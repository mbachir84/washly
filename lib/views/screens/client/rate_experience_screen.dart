// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:washly/utils/buttons.dart';
import 'package:washly/utils/constants.dart';
import 'package:washly/views/components/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateExperienceScreen extends StatelessWidget {
  const RateExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 30.0.h, bottom: 12.0.h),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GradientButton(
                text: "Submit",
                onpress: () {
                  requestSent(context: context);
                },
              ),
              10.verticalSpace,
              GradientButton(
                colors: const [
                  Color(0xff698695),
                  Color(0xffa7c5d6),
                ],
                text: 'skip',
                onpress: () {
                  Get.back();
                  //getreceipt(context: context);
                },
              ),
            ]),
      ),
      backgroundColor: const Color(0xffeaeff0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            84.verticalSpace,
            Text(
              "Please rate your experience with Washly",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
            27.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Container(
                height: 550.h,
                width: 380.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: Colors.white),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    15.verticalSpace,
                    Container(
                      height: 70.h,
                      width: 70.w,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                    ),
                    10.verticalSpace,
                    Text(
                      "Washer",
                      style: TextStyle(
                          fontSize: 13.sp, color: const Color(0xff698695)),
                    ),
                    Text(
                      "Khalid Bennani",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          color: primaryColor,
                        ),
                        Text(
                          "4.7 Rating",
                          style: TextStyle(
                              fontSize: 13.sp, color: const Color(0xff698695)),
                        ),
                      ],
                    ),
                    30.verticalSpace,
                    Text(
                      "How do you rate the wash",
                      style: TextStyle(
                          color: const Color(0xff313131),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    15.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: primaryColor,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )
                      ],
                    ),
                    30.verticalSpace,
                    Text(
                      "How do you rate the washer",
                      style: TextStyle(
                          color: const Color(0xff313131),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    15.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: primaryColor,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )
                      ],
                    ),
                    35.verticalSpace,
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: TextField(
                          maxLines: 20,
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              hintText: "Add comment",
                              border: OutlineInputBorder()),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
