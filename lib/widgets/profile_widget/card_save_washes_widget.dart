import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardSaveWashesWidget extends StatelessWidget {
  const CardSaveWashesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 91.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
          boxShadow: const [BoxShadow(color: Color(0x1a000000), blurRadius: 5)],
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xff3fc0ff),
                Color(0xff51d4d2),
              ]),
          borderRadius: BorderRadius.circular(8.r)),
      child: Stack(
        children: [
          Image.asset('assets/images/w-banner.png', fit: BoxFit.cover),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Become a washer',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold))
                      .tr(),
                  5.verticalSpace,
                  Text("Earn money on your shedule",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold))
                      .tr(),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 20.r,
              )
            ],
          ),
        ],
      ),
    );
  }
}
