import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washly/utils/buttons.dart';

class PromoCodeScreen extends StatelessWidget {
  const PromoCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6320ee),
              Color(0xFF6320ee),
              Color(0xFF55d6d0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            30.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.w),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: SvgPicture.asset(
                        'assets/images/arrow-back.svg',
                        height: 9.h,
                        width: 17,
                        color: Colors.white,
                      )),
                  16.horizontalSpace,
                  Text(
                    'Get promo code',
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ).tr(),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/discount-icon.svg"),
                20.verticalSpace,
                Text(
                  "Save on your washes!",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w800,
                      fontSize: 27.sp,
                      color: Colors.white),
                ),
                20.verticalSpace,
                Text(
                  "Earn 40 MAD at a time!",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w800,
                      fontSize: 20.sp,
                      color: Colors.white),
                ),
                25.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.w),
                  child: Text(
                    "Share your code with friends and they’ll each get 20 MAD to spend across 3 washes",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w800,
                        fontSize: 14.sp,
                        color: Colors.white),
                  ),
                ),
                25.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.w),
                  child: Text(
                    "Earn 25 MAD to spend in Washly for every friend that places their 1st order",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w800,
                        fontSize: 14.sp,
                        color: Colors.white),
                  ),
                ),
                25.verticalSpace,
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              width: MediaQuery.of(context).size.width,
              height: 60.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white.withOpacity(0.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tap to copy code",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w800,
                      fontSize: 14.sp,
                      color: const Color(0xFF5c7adf),
                    ),
                  ),
                  3.verticalSpace,
                  Text("TR892FGH",
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: const Color(0xFF5c7adf),
                              fontWeight: FontWeight.bold))
                      .tr()
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              child: GradientButton(
                  colors: const [
                    Color(0xFFF8F8F8),
                    Color(0xFFF8F8F8),
                  ],
                  allowed: true,
                  fontColor: const Color(0xFF5d69e2),
                  text: 'inviteAFreind',
                  onpress: () {
                    // controller.showDialog(context);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
