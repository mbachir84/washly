// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFeaeff0),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                Text('Support',
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff030303)))
              ]),
              25.verticalSpace,
              Text(
                "We're here to help you",
                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
              ),
              7.verticalSpace,
              Text(
                  "Please select preffered methode of contact \n and let us know how we can help you",
                  style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
              25.verticalSpace,
              ContactMethode(title: "Chat with support",icon: SvgPicture.asset("assets/images/chat-icon.svg"),),
              17.verticalSpace,
              ContactMethode(title:"Email us",icon: SvgPicture.asset("assets/images/email-icon.svg"),),
              17.verticalSpace,
              ContactMethode(title: "(+212) 684 990 001",icon: SvgPicture.asset("assets/images/phone-icon.svg"),)
            ]),
          ),
        ));
  }
}

class ContactMethode extends StatelessWidget {
  String? title;
  Widget? icon;
  ContactMethode({
    Key? key,
    this.title,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 81.h,
      width: 382.w,
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(9)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: icon!,
              ),
              5.horizontalSpace,
              Text(
                title!,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
          ),
        ],
      ),
    );
  }
}
