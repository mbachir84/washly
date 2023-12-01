import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:washly/views/components/widgets.dart';
import 'package:washly/views/screens/auth/verify_phone.dart';
import 'package:washly/views/screens/client/addresses_list_screen.dart';
import 'package:washly/views/screens/client/credit_card_screen.dart';
import 'package:washly/views/screens/client/my_coupons_page.dart';
import 'package:washly/views/screens/client/support_screen.dart';
import 'package:washly/views/screens/client/wallet_screen.dart';
import 'package:washly/views/screens/client/wash_history.dart';
import 'package:washly/widgets/profile_widget/card_save_washes_widget.dart';
import 'package:washly/widgets/profile_widget/item_profiel_widget.dart';

class ProfileItemMenuWidget extends StatelessWidget {
  const ProfileItemMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItemProfileMenu(
          title: "wallet",
          iconPath: 'assets/images/wallet-select.svg',
          data: "500 Dhs",
          onTap: () => Get.to(() => const WalletScreen(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 500)),
        ),
        ItemProfileMenu(
          title: "addresses",
          iconPath: 'assets/images/location-select-icon.svg',
          data: "",
          onTap: () => Get.to(() => const AddressesListScreen(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 500)),
        ),
        ItemProfileMenu(
          title: "creditcard",
          iconPath: 'assets/images/wallet-select.svg',
          onTap: () {
            Get.to(() => const CreditCardScreen(),
                transition: Transition.fadeIn,
                duration: const Duration(milliseconds: 500));
          },
        ),
        ItemProfileMenu(
          title: "washhistory",
          iconPath: 'assets/images/wash-history-select.svg',
          onTap: () {
            Get.to(() => const WashHistoryScreen(),
                transition: Transition.fadeIn,
                duration: const Duration(milliseconds: 500));
          },
        ),
        ItemProfileMenu(
          title: "mycoupons",
          iconPath: 'assets/images/coupon-select-icon.svg',
          description: "Share referral with friends",
          onTap: () {
            Get.to(() => const MyCouponsScreen(),
                transition: Transition.fadeIn,
                duration: const Duration(milliseconds: 500));
          },
        ),
        ItemProfileMenu(
          title: "support",
          iconPath: 'assets/images/support-select-icon .svg',
          onTap: () => Get.to(() => const SupportScreen(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 500)),
        ),
        5.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: const CardSaveWashesWidget(),
        ),
        25.verticalSpace,
        Row(
          children: [
            20.horizontalSpace,
            SvgPicture.asset(
              "assets/images/sign-out-select-icon.svg",
              height: 42.sp,
              width: 42.sp,
            ),
            16.5.horizontalSpace,
            InkWell(
              onTap: () {
                showSignOut(context: context);
                
              },
              child: Text('signout',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff030303),
                  )).tr(),
            ),
            20.horizontalSpace,
          ],
        )
      ],
    );
  }
}
