import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:washly/utils/buttons.dart';
import 'package:washly/views/screens/client/add_promo_code_screen.dart';
import 'package:washly/views/screens/client/promo_code_screen.dart';
import 'package:washly/widgets/my_coupons_widget/card_apply_coupon_widget.dart';

class MyCouponsScreen extends StatefulWidget {
  const MyCouponsScreen({super.key});

  @override
  State<MyCouponsScreen> createState() => _MyCouponsScreenState();
}

class _MyCouponsScreenState extends State<MyCouponsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffeaeff0),
        body: Column(children: [
          85.verticalSpace,
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: SvgPicture.asset(
                    'assets/images/arrow-back.svg',
                    height: 9.h,
                    width: 17,
                  )),
              9.horizontalSpace,
              Text(
                'mycoupons',
                style: TextStyle(
                  fontSize: 22.sp,
                  color: const Color(0xff030303),
                  fontWeight: FontWeight.bold,
                ),
              ).tr(),
            ],
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.w),
                child: const Text("Your promocodes (2)",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold))),
            10.verticalSpace,
            const CardApplyCouponWidget(),
            10.verticalSpace,
            const CardApplyCouponWidget(),
            10.verticalSpace
          ]),
          0.4.sh.verticalSpace,
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(children: [
                GradientButton(
                  allowed: true,
                  text: 'entrePromoCode',
                  onpress: () {
                    Get.to(() => const AddPromoCodeScreen(),
                        transition: Transition.fadeIn,
                        duration: const Duration(milliseconds: 500));
                  },
                ),
                20.verticalSpace,
                GradientButton(
                    colors: const [Color(0xff698695), Color(0xffa7c5d6)],
                    allowed: true,
                    text: 'inviteAFreind',
                    onpress: () {
                      // controller.showDialog(context);

                      Get.to(() => const PromoCodeScreen(),
                          transition: Transition.fadeIn,
                          duration: const Duration(milliseconds: 500));
                    })
              ]))
        ]));
  }
}
