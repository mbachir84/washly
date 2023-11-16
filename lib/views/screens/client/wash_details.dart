import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:washly/utils/buttons.dart';
import 'package:washly/utils/constants.dart';
import 'package:washly/views/components/widgets.dart';
import 'package:washly/views/screens/client/contact_washer.dart';

class WashDetailsScreen extends StatelessWidget {
  const WashDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(left: 24.0.h, right: 24.0.h, bottom: 12.0.h),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            GradientButton(
              colors: const [
                Color(0xff698695),
                Color(0xffa7c5d6),
              ],
              text: "contactwasher",
              onpress: () {
                Get.to(() => const ContactWasherScreen());
              },
            ),
            10.verticalSpace,
            GradientButton(
              text: 'Get receipt',
              onpress: () {
                getreceipt(context: context);
              },
            ),
          ]),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                85.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 7.0.h),
                        child: SvgPicture.asset('assets/images/arrow-back.svg'),
                      ),
                    ),
                    16.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'washdetails',
                          style: TextStyle(
                            fontSize: 22.sp,
                            color: const Color(0xff030303),
                            fontWeight: FontWeight.bold,
                          ),
                        ).tr(),
                        Text(
                          'Tue, Apr 25, 2023',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color(0xff698695),
                            fontWeight: FontWeight.w500,
                          ),
                        ).tr(),
                      ],
                    ),
                  ],
                ),
                20.verticalSpace,
                Container(
                  width: double.infinity,
                  height: 118.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff000000).withOpacity(0.1),
                        blurRadius: 10.r,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.0.w,
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(9.r),
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://firebasestorage.googleapis.com/v0/b/washly-b8ab4.appspot.com/o/user-images%2Fno-car-icon.png?alt=media&token=93afe7f5-d697-42d5-93c8-53c6e97a7a3f",
                            height: 83.h,
                            width: 83.w,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        16.horizontalSpace,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mercedes-Benz",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: darkColor2,
                                  fontWeight: FontWeight.bold),
                            ),
                            5.verticalSpace,
                            Text(
                              "GLC Coupe",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: titleColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            5.verticalSpace,
                            Text(
                              "57631 | 8",
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: titleColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                28.verticalSpace,
                Text(
                  'wash',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xff698695),
                    fontWeight: FontWeight.w500,
                  ),
                ).tr(),
                2.verticalSpace,
                Text(
                  "Basic Wash",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xff030303),
                      fontWeight: FontWeight.bold),
                ),
                12.verticalSpace,
                Container(
                  height: 1.h,
                  width: double.infinity.w,
                  color: const Color(0xff698695).withOpacity(0.2),
                ),
                12.verticalSpace,
                Text(
                  'location',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xff698695),
                    fontWeight: FontWeight.w500,
                  ),
                ).tr(),
                2.verticalSpace,
                Text(
                  "Home",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xff030303),
                      fontWeight: FontWeight.bold),
                ),
                12.verticalSpace,
                Container(
                  height: 1.h,
                  width: double.infinity.w,
                  color: const Color(0xff698695).withOpacity(0.2),
                ),
                12.verticalSpace,
                Text(
                  'paymentmethod',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xff698695),
                    fontWeight: FontWeight.w500,
                  ),
                ).tr(),
                2.verticalSpace,
                Text(
                  "wallet",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xff030303),
                      fontWeight: FontWeight.bold),
                ),
                12.verticalSpace,
                Container(
                  height: 1.h,
                  width: double.infinity.w,
                  color: const Color(0xff698695).withOpacity(0.2),
                ),
                12.verticalSpace,
                Text(
                  'price',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xff698695),
                    fontWeight: FontWeight.w500,
                  ),
                ).tr(),
                2.verticalSpace,
                Text(
                  "20 MAD",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xff030303),
                      fontWeight: FontWeight.bold),
                ),
                12.verticalSpace,
                Container(
                  height: 1.h,
                  width: double.infinity.w,
                  color: const Color(0xff698695).withOpacity(0.2),
                ),
                12.verticalSpace,
                Text(
                  'discount',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xff698695),
                    fontWeight: FontWeight.w500,
                  ),
                ).tr(),
                2.verticalSpace,
                Text(
                  "1 MAD",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xff030303),
                      fontWeight: FontWeight.bold),
                ),
                12.verticalSpace,
                Container(
                  height: 1.h,
                  width: double.infinity.w,
                  color: const Color(0xff698695).withOpacity(0.2),
                ),
                12.verticalSpace,
                Text(
                  'washer',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xff698695),
                    fontWeight: FontWeight.w500,
                  ),
                ).tr(),
                2.verticalSpace,
                Text(
                  "Khalid Bennani",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xff030303),
                      fontWeight: FontWeight.bold),
                ),
                12.verticalSpace,
                Container(
                  height: 1.h,
                  width: double.infinity.w,
                  color: const Color(0xff698695).withOpacity(0.2),
                ),
                12.verticalSpace,
                Text(
                  'washrating',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xff698695),
                    fontWeight: FontWeight.w500,
                  ),
                ).tr(),
                2.verticalSpace,
                Text(
                  "5 stars",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xff030303),
                      fontWeight: FontWeight.bold),
                ),
                12.verticalSpace,
                Container(
                  height: 1.h,
                  width: double.infinity.w,
                  color: const Color(0xff698695).withOpacity(0.2),
                ),
              ],
            ),
          ),
        ));
  }
}
