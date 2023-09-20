import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart'; 
import 'package:washly/utils/constants.dart';
import 'package:washly/utils/glassmorphism.dart';
import 'package:washly/views/components/widgets.dart';

import '../../../controllers/auth/sign_up_credit_card_controller.dart';

 

class SignUpCreditCard extends StatelessWidget {
  const SignUpCreditCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: 932.h,
      width: 430.w,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            primaryColor,
            secondaryColor,
          ])),
      child: GetBuilder<SignUpCreditCardController>(
          init: SignUpCreditCardController(),
          builder: (cont) {
            return cont.isLoading.value
                ? Center(
                    child: SpinKitDoubleBounce(
                    color: Colors.white,
                    size: 100.0.sp,
                  ))
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 29.w),
                      child: GetBuilder<SignUpCreditCardController>(
                          init: SignUpCreditCardController(),
                          builder: (controller) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                84.verticalSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 5.h,
                                      width: 80.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(2.5.r)),
                                    ),
                                    Container(
                                      height: 5.h,
                                      width: 80.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(2.5.r)),
                                    ),
                                    Container(
                                      height: 5.h,
                                      width: 80.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(2.5.r)),
                                    ),
                                    Container(
                                      height: 5.h,
                                      width: 80.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(2.5.r)),
                                    ),
                                  ],
                                ),
                                34.verticalSpace,
                                Glassmorphism(
                                  blur: 80,
                                  opacity: 0.2,
                                  radius: 90.r,
                                  child: SizedBox(
                                    width: 62.w,
                                    height: 62.w,
                                    child: Icon(CupertinoIcons.creditcard_fill,
                                        color: Colors.white, size: 30.sp),
                                  ),
                                ),
                                15.verticalSpace,
                                Text(
                                  'payway',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold),
                                ).tr(),
                                36.verticalSpace,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Radio<PayementMethod>(
                                        fillColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => Colors.white),
                                        activeColor: Colors.white,
                                        value: PayementMethod.creditcard,
                                        groupValue: controller.payementMethod,
                                        onChanged: (value) {
                                          controller.payementMethod = value!;
                                          controller.verify();
                                          controller.update();
                                        }),
                                    Text(
                                      'creditcard',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700),
                                    ).tr(),
                                    60.horizontalSpace,
                                    Radio<PayementMethod>(
                                        fillColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => Colors.white),
                                        activeColor: Colors.white,
                                        value: PayementMethod.cash,
                                        groupValue: controller.payementMethod,
                                        onChanged: (value) {
                                          controller.payementMethod = value!;
                                          controller.verify();
                                          controller.update();
                                        }),
                                    Text(
                                      'withcash',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700),
                                    ).tr()
                                  ],
                                ),
                                24.verticalSpace,
                                controller.payementMethod ==
                                        PayementMethod.creditcard
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'cardnumber',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500),
                                          ).tr(),
                                          12.verticalSpace,
                                          GetBuilder<
                                                  SignUpCreditCardController>(
                                              init:
                                                  SignUpCreditCardController(),
                                              builder: (controller) {
                                                return TextFormField(
                                                    scrollPadding:
                                                        EdgeInsets.only(
                                                            bottom: 500.h),
                                                    autofocus: true,
                                                    controller: controller
                                                        .cardController,
                                                    onChanged: (value) {
                                                      controller.checkCard();
                                                      controller
                                                              .suffixIconEnabled =
                                                          value.isNotEmpty;
                                                      controller.update();
                                                      controller.verify();
                                                    },
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(
                                                          19),
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                      CardNumberFormatter(),
                                                    ],
                                                    // textInputAction: TextInputAction.done,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 0.w,
                                                              horizontal: 20.w),
                                                      hintText:
                                                          'XXXX XXXX XXXX XXXX',
                                                      hintStyle: TextStyle(
                                                        fontSize: 21.sp,
                                                        color: Colors.grey,
                                                      ),
                                                      prefixIcon: controller
                                                              .suffixIconEnabled
                                                          ? controller
                                                                  .isMasterCard
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      SvgPicture
                                                                          .asset(
                                                                    'assets/images/mastercard.svg',
                                                                    height:
                                                                        25.h,
                                                                    width: 25.w,
                                                                  ),
                                                                )
                                                              : controller
                                                                      .isVisa
                                                                  ? Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/visa.jpg',
                                                                        height:
                                                                            25.h,
                                                                        width:
                                                                            25.w,
                                                                      ),
                                                                    )
                                                                  : Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .credit_card,
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(0.5),
                                                                        size: 24
                                                                            .w,
                                                                      ),
                                                                    )
                                                          : null,
                                                      filled: true,
                                                      suffixIcon: controller
                                                              .suffixIconEnabled
                                                          ? InkWell(
                                                              onTap: () {
                                                                controller
                                                                        .suffixIconEnabled =
                                                                    false;
                                                                controller
                                                                    .update();
                                                                controller
                                                                    .cardController
                                                                    .clear();

                                                                controller
                                                                    .update();
                                                                controller
                                                                    .verify();
                                                              },
                                                              child: Icon(
                                                                CupertinoIcons
                                                                    .xmark_circle_fill,
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.5),
                                                                size: 24.w,
                                                              ),
                                                            )
                                                          : null,
                                                      fillColor: Colors.white,
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.r),
                                                        borderSide: const BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                      ),
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.r),
                                                        borderSide: const BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.r),
                                                        borderSide: const BorderSide(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ));
                                              }),
                                          34.verticalSpace,
                                          Text(
                                            'cardholdername',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500),
                                          ).tr(),
                                          12.verticalSpace,
                                          GetBuilder<
                                                  SignUpCreditCardController>(
                                              init:
                                                  SignUpCreditCardController(),
                                              builder: (controller) {
                                                return TextFieldPrimary(
                                                  onTap: () {
                                                    controller.verify();
                                                  },
                                                  onChange: (value) {
                                                    controller.verify();
                                                  },
                                                  controller: controller
                                                      .cardHolderController,
                                                  hint: '',
                                                  visible: false,
                                                );
                                              }),
                                          34.verticalSpace,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'expiredate',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ).tr(),
                                              12.verticalSpace,
                                              GetBuilder<
                                                      SignUpCreditCardController>(
                                                  init:
                                                      SignUpCreditCardController(),
                                                  builder: (controller) {
                                                    return TextFieldPrimary(
                                                      creditCard: [
                                                        LengthLimitingTextInputFormatter(
                                                            5),
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                        CardExpirationFormatter(),
                                                      ],
                                                      onTap: () {
                                                        controller.verify();
                                                      },
                                                      onChange: (value) {
                                                        controller.verify();
                                                      },
                                                      controller: controller
                                                          .expiryDateController,
                                                      hint: 'xx/xx',
                                                      visible: false,
                                                    );
                                                  }),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          54.verticalSpace,
                                          Container(
                                              height: 244.h,
                                              width: 356.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          17.r)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/images/payement.svg',
                                                      width: 61.w),
                                                  17.verticalSpace,
                                                  Text(
                                                    'plznote',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 19.sp,
                                                        color: darkColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ).tr(),
                                                  17.verticalSpace,
                                                  Text(
                                                    'topay',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: darkColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ).tr(),
                                                ],
                                              )),
                                          27.verticalSpace,
                                        ],
                                      ),
                                MediaQuery.of(context).viewInsets.bottom == 0.0
                                    ? 70.verticalSpace
                                    : 34.verticalSpace,
                                Center(
                                  child: SizedBox(
                                      width: 356.w,
                                      child: GetBuilder<
                                              SignUpCreditCardController>(
                                          init: SignUpCreditCardController(),
                                          builder: (controller) {
                                            return InkWell(
                                              onTap: () {
                                                controller.isVerified
                                                    ? controller.submit()
                                                    : null;
                                              },
                                              child: Glassmorphism(
                                                blur: 9,
                                                opacity: controller.isVerified
                                                    ? 1.0
                                                    : 0.2,
                                                radius: 34.r,
                                                child: Container(
                                                  height: 67.h,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              34.r)),
                                                  child: Center(
                                                    child: Text(
                                                      'save',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 19.sp,
                                                          color: controller
                                                                  .isVerified
                                                              ? darkColor
                                                              : const Color(
                                                                  0xff459F98),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ).tr(),
                                                  ),
                                                ),
                                              ),
                                            );
                                          })),
                                ),
                                MediaQuery.of(context).viewInsets.bottom == 0.0
                                    ? 43.verticalSpace
                                    : 10.verticalSpace,
                                Center(
                                  child: GetBuilder<SignUpCreditCardController>(
                                      init: SignUpCreditCardController(),
                                      builder: (controller) {
                                        return InkWell(
                                          onTap: () {
                                            controller.skip();
                                          },
                                          child: Text(
                                            'skiplater',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 19.sp,
                                                fontWeight: FontWeight.bold),
                                          ).tr(),
                                        );
                                      }),
                                ),
                              ],
                            );
                          }),
                    ),
                  );
          }),
    ));
  }
}
