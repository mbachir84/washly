import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        height:116.h ,
                        width: 380.w,
                        color: Colors.blue,
                        child: const Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Column(
                            children: [Text("Your balance"),
                            Text("500 MAD")],
                          ),
                        ),
                      ),
                      106.verticalSpace,

                    ]
                    )
                    )
                    )
                    );
  }
}
