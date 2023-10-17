// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unnecessary_import

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

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

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
                                child: SvgPicture.asset(
                                    'assets/images/arrow-back.svg'))),
                        16.horizontalSpace,
                        Text('Wallet',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff030303)))
                            .tr()
                      ]),
                      31.verticalSpace,
                      Container(
                        height: 116.h,
                        width: 380.w,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                primaryColor,
                                secondaryColor,
                              ]),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 35.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Your balance",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  )),
                              Text(
                                "500 MAD",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      106.verticalSpace,
                      Text(
                        "Transactions history",
                        style: TextStyle(fontSize: 15,color: titleColor),
                      ),
                      Container(
                        height: 400,
                        // color: Colors.blue,
                        child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Divider(
                                        color: darkColor,
                                        // thickness: 1,
                                      ),
                                  Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        
                                        Text("Transaction ID: 2536987",
                                        style: TextStyle(fontSize: 16),),
                                        6.verticalSpace,
                                        Text(
                                          "April 4, 2023 at 18:30",
                                          style: TextStyle(
                                              fontSize: 13, color: Color(0xFF698695)),
                                        ),
                                      ]),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("-20 MAD",
                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                                        ],
                                      )]
                                ),
                                index == 5? Divider(color: darkColor,):Container()
                                ]
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Container();
                            },
                            itemCount: 6),
                      )
                    ]))));
  }
}
