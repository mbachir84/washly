import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardApplyCouponWidget extends StatelessWidget {
  const CardApplyCouponWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Container(
            height: 100.h,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Color(0x1a000000), blurRadius: 5)
                ],
                borderRadius: BorderRadius.circular(8.r)),
            child: Stack(children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('10% off any wash',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold))
                            .tr(),
                        5.verticalSpace,
                        Text('Expires: 6/27/2023',
                                style: TextStyle(
                                    color: const Color(0xFF698695),
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold))
                            .tr(),
                      ],
                    ),
                    
                    ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.zero),
                      ),
                      onPressed: () {},
                      child: Container(
                        width: 96.w,
                        height: 44.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            colors: [Colors.blue, Colors.cyan],
                          ),
                        ),
                        child: const Text(
                          'apply',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ).tr(),
                      ),
                    ),
                  ])
            ])));
  }
}
