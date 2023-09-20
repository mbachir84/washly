import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardCodeWidget extends StatelessWidget {
  const CardCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 91.h,
      decoration: BoxDecoration(
          boxShadow: const [BoxShadow(color: Color(0x1a000000), blurRadius: 5)],
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xff6320ee),
                Color(0xff55d6d0),
              ]),
          borderRadius: BorderRadius.circular(8.r)),
      child: Stack(
        children: [
          Image.asset('assets/images/w-banner.png', fit: BoxFit.cover),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              14.horizontalSpace,
              SvgPicture.asset('assets/images/discount-icon.svg'),
              19.horizontalSpace,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('donthavecode',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold))
                      .tr(),
                  Text('getyouwash',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500))
                      .tr(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
