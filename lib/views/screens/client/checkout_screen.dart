import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:washly/controllers/client/addresses_list_controller.dart';
import 'package:washly/controllers/client/checkout_controller.dart';
import 'package:washly/controllers/client/choose_car_controller.dart';
import 'package:washly/controllers/client/main_controller.dart';
import 'package:washly/utils/buttons.dart';
import 'package:washly/utils/constants.dart';
import 'package:washly/views/components/widgets.dart';
import 'package:washly/views/screens/client/pay_screen.dart';
import 'choose_address_screen.dart';
import 'choose_car_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<CheckoutController>(
            init: CheckoutController(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                      child: GetBuilder<MainController>(
                        init: MainController(),
                        builder: (cont) => Column(
                          children: [
                            80.verticalSpace,
                            Row(
                              children: [
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
                                Text(
                                  'washsummary',
                                  style: TextStyle(
                                      fontSize: 22.sp,
                                      color: const Color(0xff030303),
                                      fontWeight: FontWeight.bold),
                                ).tr(),
                              ],
                            ),
                            19.verticalSpace,
                            Container(
                              height: 1,
                              width: 1.sw,
                              color: const Color(0xff698695).withOpacity(0.2),
                            ),
                            18.5.verticalSpace,
                            Row(
                              children: [
                                SvgPicture.asset('assets/images/wash-icon.svg'),
                                14.horizontalSpace,
                                Text(cont.typeWash(),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff030303),
                                    )).tr(),
                                15.horizontalSpace,
                                InkWell(
                                  onTap: () {
                                    controller.infoClick();
                                  },
                                  child: Container(
                                    height: 35.w,
                                    width: 35.w,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff10a7f5)
                                            .withOpacity(0.07),
                                        borderRadius:
                                            BorderRadius.circular(5.r)),
                                    child: Icon(
                                      Icons.info_outline,
                                      size: 20.sp,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Text('${cont.priceWash()} MAD',
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff030303)))
                                    .tr(),
                              ],
                            ),
                            18.5.verticalSpace,
                            Container(
                              height: 1,
                              width: 1.sw,
                              color: const Color(0xff698695).withOpacity(0.2),
                            ),
                            18.5.verticalSpace,
                            InkWell(
                              onTap: () {
                                Get.to(
                                  () => const ChooseCarScreen(),
                                  transition: Transition.fadeIn,
                                  duration: const Duration(milliseconds: 500),
                                );
                              },
                              child: GetBuilder<ChooseCarController>(
                                init: ChooseCarController(),
                                builder: (contr) => Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/car-select-icon.svg'),
                                    14.horizontalSpace,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(contr.selectedCar.make!,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xff030303),
                                            )).tr(),
                                        Text(contr.selectedCar.licencePlate!,
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xff698695),
                                            )).tr(),
                                      ],
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: const Color(0xff313131),
                                      size: 16.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            18.5.verticalSpace,
                            Container(
                              height: 1,
                              width: 1.sw,
                              color: const Color(0xff698695).withOpacity(0.2),
                            ),
                            18.5.verticalSpace,
                            InkWell(
                              onTap: () {
                                Get.to(
                                  () => const ChosseAddressScreen(),
                                  transition: Transition.fadeIn,
                                  duration: const Duration(milliseconds: 500),
                                );
                              },
                              child: GetBuilder<AddressesListController>(
                                init: AddressesListController(),
                                builder: (cont) => Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/location-select-icon.svg'),
                                    14.horizontalSpace,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(cont.selectedAddress.name!,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xff030303),
                                            )).tr(),
                                        Text(cont.selectedAddress.description!,
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xff698695),
                                            )).tr(),
                                      ],
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: const Color(0xff313131),
                                      size: 16.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            18.5.verticalSpace,
                            Container(
                              height: 1,
                              width: 1.sw,
                              color: const Color(0xff698695).withOpacity(0.2),
                            ),
                            18.5.verticalSpace,
                            InkWell(
                              onTap: () {
                                showBottomDialog(
                                  context: context,
                                  allowBackNavigation: true,
                                  checkoutClick: false,
                                );
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/booking-select-icon.svg'),
                                  14.horizontalSpace,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('April 24, 2023',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff030303),
                                          )).tr(),
                                      Text('Wash Now',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff698695),
                                          )).tr(),
                                    ],
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: const Color(0xff313131),
                                    size: 16.sp,
                                  ),
                                ],
                              ),
                            ),
                            18.5.verticalSpace,
                            Container(
                              height: 1,
                              width: 1.sw,
                              color: const Color(0xff698695).withOpacity(0.2),
                            ),
                            18.5.verticalSpace,
                            Row(
                              children: [
                                Text('addcoupon',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff698695),
                                    )).tr(),
                                const Spacer(),
                                Text('mycoupons',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    )).tr(),
                                13.horizontalSpace,
                                SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: SvgPicture.asset(
                                        'assets/images/forward.svg')),
                              ],
                            ),
                            14.verticalSpace,
                            SizedBox(
                              width: double.infinity,
                              height: 56.h,
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  SizedBox(
                                    width: 269.w,
                                    height: 50.h,
                                    child: TextField(
                                      style: TextStyle(
                                          color: const Color(0xff698695),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                      controller: controller.couponController,
                                      // onChanged: (value){
                                      //   controller.couponController.text = value;
                                      // controller.update();
                                      // },
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff698695),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6.r),
                                            bottomLeft: Radius.circular(6.r),
                                          ),
                                          borderSide: BorderSide(
                                              color: primaryColor, width: 1.w),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6.r),
                                            bottomLeft: Radius.circular(6.r),
                                          ),
                                          borderSide: BorderSide(
                                              color: primaryColor, width: 1.w),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6.r),
                                            bottomLeft: Radius.circular(6.r),
                                          ),
                                          borderSide: BorderSide(
                                              color: primaryColor, width: 1.w),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: SizedBox(
                                        width: 124.w,
                                        height: 50.h,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor:
                                                  const Color(0xffb6e4fc),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(6.r),
                                                  bottomRight:
                                                      Radius.circular(6.r),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              controller.apply();
                                            },
                                            child: Text(controller.buttonText)
                                                .tr())),
                                  ),
                                ],
                              ),
                            ),
                            18.verticalSpace,
                            Container(
                              height: 91.h,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0x1a000000), blurRadius: 5)
                                  ],
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
                                  Image.asset('assets/images/w-banner.png',
                                      fit: BoxFit.cover),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      14.horizontalSpace,
                                      SvgPicture.asset(
                                          'assets/images/discount-icon.svg'),
                                      19.horizontalSpace,
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('donthavecode',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.bold))
                                              .tr(),
                                          Text('getyouwash',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500))
                                              .tr(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            19.verticalSpace,
                            Container(
                              height: 1,
                              width: 1.sw,
                              color: const Color(0xff698695).withOpacity(0.2),
                            ),
                            19.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'discount',
                                  style: TextStyle(
                                    color: const Color(0xff698695),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ).tr(),
                                Text(
                                  '0 MAD',
                                  style: TextStyle(
                                    color: const Color(0xff698695),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ).tr(),
                              ],
                            ),
                            8.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'subtotal',
                                  style: TextStyle(
                                    color: const Color(0xff698695),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ).tr(),
                                Text(
                                  '${cont.priceWash()} MAD',
                                  style: TextStyle(
                                    color: const Color(0xff698695),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ).tr(),
                              ],
                            ),
                            8.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'totaltopay',
                                  style: TextStyle(
                                    color: const Color(0xff030303),
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ).tr(),
                                Text(
                                  '${cont.priceWash()} MAD',
                                  style: TextStyle(
                                    color: const Color(0xff030303),
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ).tr(),
                              ],
                            ),
                            29.verticalSpace,
                            GradientButton(
                              text: 'confirmandpay',
                              onpress: () {
                                Get.to(
                                  () => const PayScreen(),
                                  transition: Transition.fadeIn,
                                  duration: const Duration(milliseconds: 500),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    AnimatedSnackbar(
                        height: controller.height,
                        title: controller.snackBarTitle,
                        subtitle: controller.snackBarSubTitle,
                        state: controller.state),
                  ],
                ),
              );
            }));
  }
}
