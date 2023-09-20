import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:washly/utils/buttons.dart';

deleteSheet(context, String title, body, onPress, loading) => showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 501.h,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r))),
          child: Column(
            children: [
              43.verticalSpace,
              SvgPicture.asset('assets/images/caution-icon.svg'),
              29.verticalSpace,
              Text(
                '${'delete'.tr()} $title',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
              13.verticalSpace,
              Text(
                body,
                style: TextStyle(fontSize: 15.sp),
                textAlign: TextAlign.center,
              ),
              37.verticalSpace,
              GradientButton(
                text: '${'delete'.tr()} ${title.tr()}',
                onpress: onPress,
                colors: const [Color(0xFF698695), Color(0xFFa7c5d6)],
                loading: loading,
                width: 382.w,
                
              ),
              23.verticalSpace,
              GradientButton(
                text: 'close'.tr(),
                onpress: () => Get.back(),
                width: 382.w,

              ),
              41.verticalSpace
            ],
          ),
        ),
      ),
    );
