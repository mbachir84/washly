// ignore_for_file: avoid_unnecessary_containers

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:washly/controllers/client/contact_washer_controller.dart';
import 'package:washly/utils/buttons.dart';
import 'package:washly/utils/constants.dart';
import 'package:washly/views/components/widgets.dart';

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
                  onpress: () {
                    requestSent(context: context);
                  },
                ),
                10.verticalSpace,
                GradientButton(
                  text: 'Close',
                  onpress: () {
                    Get.back();
                    //getreceipt(context: context);
                  },
                ),
              ]),
        ),
        body: SingleChildScrollView(
          child: GetBuilder<ContactWasherController>(
            init: ContactWasherController(),
            builder: (controller) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(children: [
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
                              child: SvgPicture.asset(
                                  'assets/images/arrow-back.svg'))),
                      16.horizontalSpace,
                      Text('Contact Washer',
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xff030303)))
                          .tr()
                    ]),
                  ],
                ),
                22.verticalSpace,
                const Divider(
                  thickness: 1,
                ),
                16.verticalSpace,
                Row(
                  children: [
                    Image.asset(
                      'assets/images/default.png',
                      width: 66.w,
                      height: 66.h,
                    ),
                    18.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('washer',
                            style: TextStyle(
                              color: const Color(0xff698695),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            )),
                        Text('Khalid Bennani',
                            style: TextStyle(
                              color: const Color(0xff030303),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            )),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: primaryColor,
                              size: 15.sp,
                            ),
                            Text(
                              '4.7 Rating',
                              style: TextStyle(
                                color: const Color(0xff698695),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                16.verticalSpace,
                const Divider(
                  thickness: 1,
                ),
                16.verticalSpace,
                Text(
                  "Why would you like to contact washer?",
                  // textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                10.verticalSpace,
                Text(
                  "Please select a reason or add your comment",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: const Color(0xff313131)),
                ),
                10.verticalSpace,
                const Divider(
                  thickness: 1,
                ),
                10.verticalSpace,
                InkWell(
                  onTap: () {
                    controller.comment = Comment.notWashedProperly;
                    controller.update();
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Radio<Comment>(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => controller.comment ==
                                            Comment.notWashedProperly
                                        ? primaryColor
                                        : const Color(0xff698695)),
                                activeColor: Colors.white,
                                value: Comment.notWashedProperly,
                                groupValue: controller.comment,
                                onChanged: (value) {
                                  controller.comment = value!;
                                  controller.update();
                                }),
                          ),
                        ),
                        15.horizontalSpace,
                        Text(
                          "Car wasn't washed properly",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                10.verticalSpace,
                const Divider(
                  thickness: 1,
                ),
                10.verticalSpace,
                InkWell(
                  onTap: () {
                    controller.comment = Comment.newDamages;
                    controller.update();
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Radio<Comment>(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        controller.comment == Comment.newDamages
                                            ? primaryColor
                                            : const Color(0xff698695)),
                                activeColor: Colors.white,
                                value: Comment.newDamages,
                                groupValue: controller.comment,
                                onChanged: (value) {
                                  controller.comment = value!;
                                  controller.update();
                                }),
                          ),
                        ),
                        15.horizontalSpace,
                        Text(
                          "I see new damages after wash",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                10.verticalSpace,
                const Divider(
                  thickness: 1,
                ),
                10.verticalSpace,
                InkWell(
                  onTap: () {
                    controller.comment = Comment.inappropriateBehavior;
                    controller.update();
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Radio<Comment>(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => controller.comment ==
                                            Comment.inappropriateBehavior
                                        ? primaryColor
                                        : const Color(0xff698695)),
                                activeColor: Colors.white,
                                value: Comment.inappropriateBehavior,
                                groupValue: controller.comment,
                                onChanged: (value) {
                                  controller.comment = value!;
                                  controller.update();
                                }),
                          ),
                        ),
                        15.horizontalSpace,
                        Text(
                          "Inappropriate washer behavior",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                10.verticalSpace,
                const Divider(
                  thickness: 1,
                ),
                6.verticalSpace,
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      // contentPadding:
                      //     EdgeInsets.symmetric(vertical: 12.5, horizontal: 9.0),
                      hintText: 'Type your comment here',
                      hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF698695),
                      ),
                    ),
                  ),
                ),
                20.verticalSpace,
                const Divider(
                  thickness: 1,
                ),
              ]),
            ),
          ),
        ));
  }
}
