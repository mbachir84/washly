import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:washly/utils/buttons.dart';
import 'package:washly/widgets/add_coupons_widget/text_field_widget.dart';
import 'package:washly/widgets/profile_widget/card_code_widget.dart';

class AddPromoCodeScreen extends StatelessWidget {
  const AddPromoCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          leadingWidth: 40.w,
          elevation: 0,
          title: const Text('Enter promo code',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          leading: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Get.back();
              },
              icon: SvgPicture.asset("assets/images/arrow-back.svg"))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(
                  height: 90.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Type your coupon code here',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: const Color(0xff698695),
                          fontWeight: FontWeight.bold,
                        ),
                      ).tr(),
                      15.verticalSpace,
                      TextFieldWidget(),
                    ],
                  ),
                ),
                20.verticalSpace,
                const CardCodeWidget()
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
            child: GradientButton(
              allowed: true,
              text: 'apply',
              onpress: () {},
            ),
          ),
        ],
      ),
    );
  }
}
