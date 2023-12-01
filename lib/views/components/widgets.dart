// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'dart:ui';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:easy_localization/easy_localization.dart' as u;
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:washly/controllers/client/add_car_controller.dart';
import 'package:washly/controllers/client/add_manually_controller.dart';
import 'package:washly/controllers/client/appoitment_controller.dart';
import 'package:washly/controllers/client/checkout_controller.dart';
import 'package:washly/controllers/client/contact_washer_controller.dart';
import 'package:washly/controllers/client/main_controller.dart';
import 'package:washly/controllers/client/opinion_controller.dart';
import 'package:washly/utils/buttons.dart';
import 'package:washly/utils/constants.dart';
import 'package:washly/views/screens/auth/verify_phone.dart';
import 'package:washly/views/screens/client/checkout_screen.dart';
import 'package:washly/views/screens/client/home_screen.dart';
import 'package:washly/views/screens/client/main_screen.dart';
import 'package:washly/views/screens/loading_screen.dart';

import '../screens/client/order_screen.dart';
import '../screens/client/washer_found_screen.dart';

class TextFieldPrimary extends StatefulWidget {
  String hint;
  Icon? inputIcon;
  bool visible;
  Function(String)? onChange;
  bool hasIcon;
  List<TextInputFormatter> creditCard;
  bool enabled;
  TextEditingController? controller;
  String? Function(String?)? validator;

  VoidCallback? onTap;
  TextFieldPrimary({
    this.enabled = true,
    required this.hint,
    this.inputIcon,
    required this.visible,
    this.onTap,
    this.onChange,
    this.hasIcon = true,
    this.creditCard = const [],
    this.controller,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  State<TextFieldPrimary> createState() => _TextFieldPrimaryState();
}

class _TextFieldPrimaryState extends State<TextFieldPrimary> {
  bool suffixIconEnabled = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54.h,
      child: TextFormField(
        autofocus: true,
        scrollPadding: EdgeInsets.only(bottom: 500.h),
        textCapitalization: TextCapitalization.words,
        inputFormatters: widget.creditCard,
        onChanged: (value) {
          widget.onChange!(value);
          setState(() {
            suffixIconEnabled = value.isNotEmpty;
          });
        },
        enabled: widget.enabled,
        controller: widget.controller,
        obscureText: widget.visible,
        validator: widget.validator,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 20.w),
          hintText: u.tr(widget.hint),
          hintStyle: TextStyle(
            fontSize: 21.sp,
            color: Colors.grey,
          ),
          filled: true,
          suffixIcon: suffixIconEnabled
              ? InkWell(
                  onTap: () {
                    setState(() {
                      suffixIconEnabled = false;
                    });
                    widget.controller!.clear();
                    widget.onTap!();
                  },
                  child: Icon(
                    CupertinoIcons.xmark_circle_fill,
                    color: Colors.grey.withOpacity(0.5),
                    size: 24.w,
                  ),
                )
              : null,
          fillColor: widget.enabled
              ? Colors.white
              : const Color.fromARGB(255, 242, 242, 242),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class AnimatedSnackbar extends StatelessWidget {
  double height;
  String title;
  String subtitle;
  bool state;
  AnimatedSnackbar(
      {required this.height,
      required this.title,
      required this.subtitle,
      required this.state,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: state ? successGradient : errorGradient,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            height > 8
                ? Text(title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold))
                    .tr()
                : Container(),
            height > 8
                ? Text(subtitle,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold))
                    .tr()
                : Container(),
          ],
        ));
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue previousValue,
    TextEditingValue nextValue,
  ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

class CardExpirationFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueString = newValue.text;
    String valueToReturn = '';

    for (int i = 0; i < newValueString.length; i++) {
      if (newValueString[i] != '/') valueToReturn += newValueString[i];
      var nonZeroIndex = i + 1;
      final contains = valueToReturn.contains(RegExp(r'\/'));
      if (nonZeroIndex % 2 == 0 &&
          nonZeroIndex != newValueString.length &&
          !(contains)) {
        valueToReturn += '/';
      }
    }
    return newValue.copyWith(
      text: valueToReturn,
      selection: TextSelection.fromPosition(
        TextPosition(offset: valueToReturn.length),
      ),
    );
  }
}

Future showBottomDialog<T>(
    {required BuildContext context,
    bool allowBackNavigation = false,
    bool checkoutClick = true}) {
  final controller = Get.put(CheckoutController());

  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: const Color(0xffeaeff0),
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    isDismissible: allowBackNavigation,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: WillPopScope(
        onWillPop: () async => allowBackNavigation,
        child: StatefulBuilder(builder: (context, setInnerState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 34.verticalSpace,
              Container(
                height: 34.h,
                width: double.infinity.w,
                decoration: BoxDecoration(
                    color: const Color(0xffeaeff0),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r))),
              ),
              Padding(
                padding: EdgeInsets.only(left: 24.0.w),
                child: Text(
                  'selectday',
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: const Color(0xff8aa7b7),
                      fontWeight: FontWeight.w600),
                ).tr(),
              ),
              10.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 24.0.w),
                child: GetBuilder<CheckoutController>(
                  builder: (controller) => DatePicker(
                    (controller.startingDate.toInt() < 20)
                        ? DateTime
                            .now() //before 21:00 the first date is current time
                        : DateTime.now().add(Duration(
                            days:
                                1)), //after 21:00 the first date is tomorrows date
                    width: 70.w,
                    controller: controller.datePickerController,
                    height: 100.w,
                    dateTextStyle: TextStyle(
                        fontSize: 24.sp,
                        color: const Color(0xff030303),
                        fontWeight: FontWeight.bold),
                    dayTextStyle: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xff8aa7b7),
                        decorationStyle: TextDecorationStyle.solid,
                        fontWeight: FontWeight.w500),
                    monthTextStyle: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xff8aa7b7),
                        decorationStyle: TextDecorationStyle.solid,
                        fontWeight: FontWeight.w500),
                    initialSelectedDate: (controller.startingDate.toInt() < 20)
                        ? controller.dateValue
                        : controller.tomorowDate!,
                    // controller.dateValue ,
                    deactivatedColor: Colors.white,
                    selectionColor: primaryColor,
                    selectedTextColor: Colors.white,
                    onDateChange: (date) {
                      setInnerState(() {
                        controller.date = date;
                        controller.dateValue = date;
                        // controller.tomorowDate = date;
                        controller.checkDay();
                        // controller.selectingController();
                        controller.datePickerController
                            .setDateAndAnimate(controller.date!);
                      });
                    },
                  ),
                ),
              ),
              29.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 24.0.w),
                child: Text(
                  'selecttime',
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: const Color(0xff8aa7b7),
                      fontWeight: FontWeight.w600),
                ).tr(),
              ),
              10.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 24.0.w),
                child: SizedBox(
                  height: 62.w,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        controller.isToday ? 21 - controller.startingDate : 14,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {},
                        child: InkWell(
                          onTap: () {
                            setInnerState(() {
                              print(controller.startingDate.toInt());
                              controller.selectedTime = index;
                              controller.counter = index;

                              controller.selectingController();
                              controller.allowed = true;
                            });
                          },
                          child: index == 0
                              ? Visibility(
                                  visible: (controller.isToday &&
                                      controller.startingDate.toInt() < 20),
                                  child: SizedBox(
                                    width: 123.w,
                                    child: Column(
                                      children: [
                                        Container(
                                            width: 123.w,
                                            height: 42.h,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: (index ==
                                                                controller
                                                                    .counter &&
                                                            controller
                                                                    .isToday ==
                                                                true)
                                                        ? primaryColor
                                                        : Colors.transparent,
                                                    width: 2),
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(6.8.r),
                                                    topRight:
                                                        Radius.circular(6.8.r)),
                                                color: Colors.white),
                                            child: Center(
                                              child: Text("washnow",
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: (index ==
                                                                      controller
                                                                          .counter &&
                                                                  controller
                                                                          .isToday ==
                                                                      true)
                                                              ? primaryColor
                                                              : const Color(
                                                                  0xff030303),
                                                          fontWeight:
                                                              FontWeight.bold))
                                                  .tr(),
                                            )),
                                        0.verticalSpace,
                                        Container(
                                            height: 20.h,
                                            decoration: BoxDecoration(
                                              // border: Border(
                                              //   bottom: BorderSide(
                                              //       width: 2.0,
                                              //       color: primaryColor),
                                              // ),
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(6.8.r),
                                                  bottomRight:
                                                      Radius.circular(6.8.r)),
                                              color: (index ==
                                                          controller.counter &&
                                                      controller.isToday ==
                                                          true)
                                                  ? primaryColor
                                                  : const Color(0xff030303),
                                            ),
                                            child: Center(
                                              child: Text("waiting",
                                                      style: TextStyle(
                                                          fontSize: 9.sp,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500))
                                                  .tr(),
                                            )),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 123.w,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: (index == controller.counter &&
                                                  controller
                                                      .dateFormat.isNotEmpty)
                                              ? primaryColor
                                              : Colors.transparent,
                                          width: 2),
                                      borderRadius:
                                          BorderRadius.circular(6.8.r),
                                      color: Colors.white),
                                  child: Center(
                                    child: Text(
                                        // "${07 + index} :00 - ${7 + index + 1} :00  ",
                                        (controller.isToday &&
                                                controller.startingDate
                                                        .toInt() >
                                                    7)
                                            ? "${controller.startingDate.toInt() + index}:00 -${controller.startingDate.toInt() + index + 1}:00"
                                            : "${07 + index} :00 - ${7 + index + 1} :00  ",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color:
                                                (index == controller.counter &&
                                                        controller.dateFormat
                                                            .isNotEmpty)
                                                    ? primaryColor
                                                    : const Color(0xff030303),
                                            fontWeight: FontWeight.bold)),
                                  )),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return 7.horizontalSpace;
                    },
                  ),
                ),
              ),
              44.verticalSpace,
              Center(
                child: GetBuilder<CheckoutController>(
                  builder: (controller) => SizedBox(
                    width: 382.w,
                    child: GradientButton(
                      allowed: controller.allowed,
                      text: 'checkout',
                      onpress: () {
                        Get.back();
                        checkoutClick
                            ? Get.to(() => const CheckoutScreen(),
                                transition: Transition.fadeIn,
                                duration: const Duration(milliseconds: 500))
                            : null;
                      },
                    ),
                  ),
                ),
              ),
              43.verticalSpace,
            ],
          );
        }),
      ),
    ),
  );
}

Future showDetailDialog<T>({
  required BuildContext context,
  bool allowBackNavigation = false,
}) {
  final controller = Get.put(MainController());
  return showModalBottomSheet(
    backgroundColor: const Color(0xffeaeff0),
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    isDismissible: allowBackNavigation,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: WillPopScope(
          onWillPop: () async => allowBackNavigation,
          child: StatefulBuilder(builder: (context, setInnerState) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 149.h,
                            child: Image.asset(
                              'assets/images/washing.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 51,
                            left: 41,
                            child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.typeWash(),
                                      style: TextStyle(
                                          fontSize: 33.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                    ).tr(),
                                    10.verticalSpace,
                                    Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.time,
                                          color: Colors.white,
                                          size: 15.sp,
                                        ),
                                        10.horizontalSpace,
                                        Text(
                                          "aroundtime",
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ).tr(),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  23.verticalSpace,
                  Padding(
                    padding: EdgeInsets.only(left: 44.0.w),
                    child: Text("washincludes",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: const Color(0xff8aa7b7),
                                fontWeight: FontWeight.w600))
                        .tr(),
                  ),
                  14.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 44.0.w),
                    child: Text("desc",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: const Color(0xff030303),
                                fontWeight: FontWeight.w600))
                        .tr(),
                  ),
                  65.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 44.0.w),
                    child: GradientButton(
                      text: "understood",
                      onpress: () {
                        Get.back();
                      },
                    ),
                  ),
                  41.verticalSpace,
                ],
              ),
            );
          }),
        ),
      ),
    ),
  );
}

Future showPayementStatusDialog<T>(
    {required BuildContext context,
    bool allowBackNavigation = false,
    bool status = true}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    isDismissible: allowBackNavigation,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: WillPopScope(
          onWillPop: () async => allowBackNavigation,
          child: StatefulBuilder(builder: (context, setInnerState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 42.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 110.w,
                      width: 110.w,
                      decoration: BoxDecoration(
                        color: !status
                            ? const Color(0xfffff0e6)
                            : const Color(0xffcbf4df),
                        borderRadius: BorderRadius.circular(55.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          status
                              ? Container(
                                  width: 44.w,
                                  height: 44.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff39d788),
                                    borderRadius: BorderRadius.circular(55.r),
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                )
                              : Icon(
                                  CupertinoIcons.exclamationmark_triangle_fill,
                                  color: const Color(0xffff8d41),
                                  size: 49.sp,
                                ),
                        ],
                      ),
                    ),
                    29.verticalSpace,
                    status
                        ? Text('thanksforpayment',
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black))
                            .tr()
                        : Text('payementdidn',
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black))
                            .tr(),
                    10.verticalSpace,
                    status
                        ? Text('wewillfindyouwasher',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff030303)))
                            .tr()
                        : Text('Please double check or change your\n payment method',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff030303)))
                            .tr(),
                    status ? 73.verticalSpace : 45.verticalSpace,
                    !status
                        ? SizedBox(
                            width: 382.w,
                            child: GradientButton(
                              text: "close",
                              onpress: () {
                                Get.back();
                                Get.to(
                                  () => const OrderScreen(),
                                  transition: Transition.rightToLeft,
                                  duration: 500.milliseconds,
                                );
                              },
                            ),
                          )
                        : Container(),
                    !status ? 45.verticalSpace : Container(),
                  ],
                )
              ],
            );
          }),
        ),
      ),
    ),
  );
}

Future showOrderSheet<T>({required BuildContext context, bool status = true}) {
  return showModalBottomSheet(
    barrierColor: Colors.transparent,
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    isDismissible: false,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(0),
      child: WillPopScope(
        onWillPop: () async => false,
        child: StatefulBuilder(builder: (context, setInnerState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 42.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xfff2f5f6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'arrivingaddress',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff698695),
                      ),
                    ).tr(),
                  ),
                ),
                39.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          'assets/images/location-select-icon.svg'),
                      14.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Home',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff030303),
                              )).tr(),
                          Text('Rez de, 443 Bd Al Hassan Al Alaoui',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff698695),
                              )).tr(),
                        ],
                      ),
                    ],
                  ),
                ),
                39.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                  child: SizedBox(
                    width: 382.w,
                    height: 67.h,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xfff2f5f6),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(33.r),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Get.to(
                          //   () => const WasherFoundScreen(),
                          //   transition: Transition.rightToLeft,
                          //   duration: 500.milliseconds,
                          // );
                          // Get.to(() => LoadingWidget());
                          showCancelWash(context: context);
                        },
                        child: Text(
                          'cancelwash',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff698695),
                          ),
                        ).tr()),
                  ),
                ),
                43.verticalSpace,
              ],
            ),
          );
        }),
      ),
    ),
  );
}

Future showOrderDialog<T>({required BuildContext context, bool status = true}) {
  return showModalBottomSheet(
    barrierColor: Colors.transparent,
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    isDismissible: false,
    isScrollControlled: false,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(0),
      child: WillPopScope(
        onWillPop: () async => false,
        child: StatefulBuilder(builder: (context, setInnerState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 29.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/default.png',
                        width: 66.w,
                        height: 66.h,
                      ),
                      18.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('washer',
                              style: TextStyle(
                                color: const Color(0xff698695),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              )),
                          Text('Khalid Bennani',
                              style: TextStyle(
                                color: const Color(0xff030303),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              )),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: primaryColor,
                                size: 15.sp,
                              ),
                              Text(
                                '4.7 Rating',
                                style: TextStyle(
                                  color: const Color(0xff698695),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        'assets/images/message.svg',
                        height: 44.h,
                        width: 44.w,
                      ),
                      14.horizontalSpace,
                      SvgPicture.asset(
                        'assets/images/phone.svg',
                        height: 44.h,
                        width: 44.w,
                      ),
                    ],
                  ),
                ),
                22.verticalSpace,
                Container(
                  height: 1,
                  width: 1.sw,
                  color: const Color(0xff698695).withOpacity(0.2),
                ),
                24.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          'assets/images/location-select-icon.svg'),
                      14.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('arrivingtime',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff698695),
                              )).tr(),
                          Text('12 - 15 min',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff030303),
                              )).tr(),
                        ],
                      ),
                    ],
                  ),
                ),
                ///////////
                23.verticalSpace,
                Container(
                  height: 42.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color(0xffe5e5e5),
                        offset: Offset(0, -12.0),
                        blurRadius: 25.0,
                      ),
                    ],
                    color: const Color(0xfff2f5f6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'addressunder',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff698695),
                      ),
                    ).tr(),
                  ),
                ),
                14.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          'assets/images/location-select-icon.svg'),
                      14.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Home',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff030303),
                              )).tr(),
                          Text('Rez de, 443 Bd Al Hassan Al Alaoui',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff698695),
                              )).tr(),
                        ],
                      ),
                    ],
                  ),
                ),
                9.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                  child: Container(
                    height: 1,
                    width: 1.sw,
                    color: const Color(0xff698695).withOpacity(0.2),
                  ),
                ),
                9.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/images/car-select-icon.svg'),
                      14.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mercedes-Benz',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff030303),
                              )).tr(),
                          Text('57631 | 8',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff698695),
                              )).tr(),
                        ],
                      ),
                    ],
                  ),
                ),
                39.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                  child: SizedBox(
                    width: 382.w,
                    height: 67.h,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xfff2f5f6),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(33.r),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Get.offAll(
                          //   () => const HomeScreen(),
                          //   transition: Transition.rightToLeft,
                          //   duration: 500.milliseconds,
                          // );
                          // Get.back();
                          // showOrderSheet(context: context, status: true);
                          showCancelWash(context: context);
                        },
                        child: Text(
                          'cancelwash',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff698695),
                          ),
                        ).tr()),
                  ),
                ),
                43.verticalSpace,
              ],
            ),
          );
        }),
      ),
    ),
  );
}

Future showWashStarted<T>({required BuildContext context, bool status = true}) {
  return showModalBottomSheet(
    barrierColor: Colors.transparent,
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    isDismissible: false,
    isScrollControlled: false,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(0),
      child: WillPopScope(
        onWillPop: () async => false,
        child: StatefulBuilder(builder: (context, setInnerState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Container(
                //   height: 29.h,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.only(
                //       topLeft: Radius.circular(20.r),
                //       topRight: Radius.circular(20.r),
                //     ),
                //   ),
                // ),
                Container(
                  height: 42.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color(0xffe5e5e5),
                        offset: Offset(0, -12.0),
                        blurRadius: 25.0,
                      ),
                    ],
                    color: const Color(0xfff2f5f6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'addressunder',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff698695),
                      ),
                    ).tr(),
                  ),
                ),
                14.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          'assets/images/location-select-icon.svg'),
                      14.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Home',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff030303),
                              )).tr(),
                          Text('Rez de, 443 Bd Al Hassan Al Alaoui',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff698695),
                              )).tr(),
                        ],
                      ),
                    ],
                  ),
                ),
                9.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                  child: Container(
                    height: 1,
                    width: 1.sw,
                    color: const Color(0xff698695).withOpacity(0.2),
                  ),
                ),
                9.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/images/car-select-icon.svg'),
                      14.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mercedes-Benz',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff030303),
                              )).tr(),
                          Text('57631 | 8',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff698695),
                              )).tr(),
                        ],
                      ),
                    ],
                  ),
                ),
                26.verticalSpace,
                //////
                Container(
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color(0xffe5e5e5),
                        offset: Offset(0, -12.0),
                        blurRadius: 25.0,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/default.png',
                          width: 66.w,
                          height: 66.h,
                        ),
                        18.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('washer',
                                style: TextStyle(
                                  color: const Color(0xff698695),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                )),
                            Text('Khalid Bennani',
                                style: TextStyle(
                                  color: const Color(0xff030303),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                )),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: primaryColor,
                                  size: 15.sp,
                                ),
                                Text(
                                  '4.7 Rating',
                                  style: TextStyle(
                                    color: const Color(0xff698695),
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          'assets/images/message.svg',
                          height: 44.h,
                          width: 44.w,
                        ),
                        14.horizontalSpace,
                        SvgPicture.asset(
                          'assets/images/phone.svg',
                          height: 44.h,
                          width: 44.w,
                        ),
                      ],
                    ),
                  ),
                ),
                
                ///////////
                23.verticalSpace,

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                  child: SizedBox(
                    width: 382.w,
                    height: 67.h,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xfff2f5f6),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(33.r),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Get.offAll(
                          //   () => const HomeScreen(),
                          //   transition: Transition.rightToLeft,
                          //   duration: 500.milliseconds,
                          // );
                          // Get.back();
                          // showOrderSheet(context: context, status: true);
                          showCancelWash(context: context);
                        },
                        child: Text(
                          'cancelwash',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff698695),
                          ),
                        ).tr()),
                  ),
                ),
                43.verticalSpace,
              ],
            ),
          );
        }),
      ),
    ),
  );
}

Future showCancel<T>({
  required BuildContext context,
  bool allowBackNavigation = true,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    isDismissible: allowBackNavigation,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: WillPopScope(
          onWillPop: () async => allowBackNavigation,
          child: StatefulBuilder(builder: (context, setInnerState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 42.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 110.w,
                      width: 110.w,
                      decoration: BoxDecoration(
                        color: const Color(0xfffff0e6),
                        borderRadius: BorderRadius.circular(55.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.exclamationmark_triangle_fill,
                            color: const Color(0xffff8d41),
                            size: 49.sp,
                          ),
                        ],
                      ),
                    ),
                    29.verticalSpace,
                    Text('canceladdingcar',
                            style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))
                        .tr(),
                    10.verticalSpace,
                    Text('usure',
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff030303)))
                        .tr(),
                    45.verticalSpace,
                    SizedBox(
                      width: 382.w,
                      child: GradientButton(
                        text: "keepadding",
                        onpress: () {
                          Get.back();
                        },
                      ),
                    ),
                    23.verticalSpace,
                    SizedBox(
                      width: 382.w,
                      child: GradientButton(
                        colors: const [Color(0xff698695), Color(0xffa7c5d6)],
                        text: "canceladding",
                        onpress: () {
                          Get.delete<AddCarController>();
                          Get.back();
                          Get.back();
                        },
                      ),
                    ),
                    45.verticalSpace,
                  ],
                )
              ],
            );
          }),
        ),
      ),
    ),
  );
}

Future deleteCarDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onConfirm,
  bool allowBackNavigation = true,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    isDismissible: allowBackNavigation,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: WillPopScope(
          onWillPop: () async => allowBackNavigation,
          child: StatefulBuilder(builder: (context, setInnerState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 42.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 110.w,
                      width: 110.w,
                      decoration: BoxDecoration(
                        color: const Color(0xfffff0e6),
                        borderRadius: BorderRadius.circular(55.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.exclamationmark_triangle_fill,
                            color: const Color(0xffff8d41),
                            size: 49.sp,
                          ),
                        ],
                      ),
                    ),
                    29.verticalSpace,
                    Text(title,
                            style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))
                        .tr(),
                    10.verticalSpace,
                    Text(content,
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff030303)))
                        .tr(),
                    45.verticalSpace,
                    SizedBox(
                      width: 382.w,
                      child: GradientButton(
                        text: "deletecar",
                        onpress: () {
                          onConfirm();
                          Get.back();
                        },
                      ),
                    ),
                    23.verticalSpace,
                    SizedBox(
                      width: 382.w,
                      child: GradientButton(
                        colors: const [Color(0xff698695), Color(0xffa7c5d6)],
                        text: "close",
                        onpress: () {
                          Get.back();
                        },
                      ),
                    ),
                    45.verticalSpace,
                  ],
                )
              ],
            );
          }),
        ),
      ),
    ),
  );
}

Future carRequestDialog<T>(
    {required BuildContext context, bool allowBackNavigation = false}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    isDismissible: false,
    enableDrag: false,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: WillPopScope(
          onWillPop: () async => allowBackNavigation,
          child: StatefulBuilder(builder: (context, setInnerState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 42.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 110.w,
                      width: 110.w,
                      decoration: BoxDecoration(
                        color: const Color(0xffcbf4df),
                        borderRadius: BorderRadius.circular(55.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 44.w,
                            height: 44.w,
                            decoration: BoxDecoration(
                              color: const Color(0xff39d788),
                              borderRadius: BorderRadius.circular(55.r),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    29.verticalSpace,
                    Text('requestsent',
                            style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))
                        .tr(),
                    10.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48.0.w),
                      child: Center(
                        child: Text('wereview',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff030303)))
                            .tr(),
                      ),
                    ),
                    49.verticalSpace,
                    SizedBox(
                      width: 382.w,
                      child: GradientButton(
                        text: "close",
                        onpress: () {
                          Get.back();
                          Get.to(
                            () => const HomeScreen(),
                            transition: Transition.rightToLeft,
                            duration: 500.milliseconds,
                          );
                          Get.delete<AddManuallyController>();
                        },
                      ),
                    ),
                    45.verticalSpace,
                  ],
                )
              ],
            );
          }),
        ),
      ),
    ),
  );
}

class AppointmentWidget extends StatelessWidget {
  String title;
  bool status = true;
  String? content;
  String? date;
  AppointmentWidget({
    super.key,
    required this.title,
    this.content,
    required this.status,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.0.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                status
                    ? Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff313131),
                          fontSize: 18.sp,
                        ),
                      ).tr()
                    : Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/warning.svg',
                            width: 20.w,
                            height: 20.w,
                          ),
                          10.horizontalSpace,
                          Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffff4141),
                              fontSize: 18.sp,
                            ),
                          ).tr()
                        ],
                      ),
                3.verticalSpace,
                Text(
                  'Mercedes-Benz  |  57631  8',
                  style: TextStyle(
                    color: status
                        ? const Color(0xff698695)
                        : const Color(0xffb3c2c9),
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ).tr(),
                9.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    status
                        ? SvgPicture.asset(
                            'assets/images/app-select-icon.svg',
                            height: 42.h,
                            width: 42.h,
                          )
                        : Stack(
                            children: [
                              SvgPicture.asset(
                                'assets/images/disabled.svg',
                                height: 42.h,
                                width: 42.h,
                              ),
                              Container(
                                height: 42.h,
                                width: 42.h,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(21.r),
                                ),
                              )
                            ],
                          ),
                    11.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tue, April 25, 2023',
                          style: TextStyle(
                            color: status
                                ? const Color(0xff030303)
                                : const Color(0xff030303).withOpacity(0.4),
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                          ),
                        ).tr(),
                        3.verticalSpace,
                        Text(
                          '17:00 - 17:30',
                          style: TextStyle(
                            color: status
                                ? const Color(0xff030303)
                                : const Color(0xff030303).withOpacity(0.4),
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                          ),
                        ).tr(),
                      ],
                    )
                  ],
                )
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: const Color(0xff313131),
              size: 16.sp,
              // weight: 22,
            ),
          ],
        ),
      ),
    );
  }
}

Future showOpinionDialog<T>({
  required BuildContext context,
  bool allowBackNavigation = true,
}) {
  // final controller = Get.put(OpinionController());

  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    isScrollControlled: true,
    isDismissible: allowBackNavigation,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: WillPopScope(
          onWillPop: () async => allowBackNavigation,
          child: StatefulBuilder(builder: (context, setInnerState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 32.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        22.verticalSpace,
                        Text('Your opinion matters',
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black))
                            .tr(),
                        10.verticalSpace,
                        Text('Please tell us why you cancelled the wash?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff030303)))
                            .tr(),
                        37.verticalSpace,
                        Divider(
                          thickness: 1,
                        ),
                        10.verticalSpace,
                        GetBuilder<OpinionController>(
                          init: OpinionController(),
                          builder: (controller) => InkWell(
                            onTap: () {
                              controller.opinion = Opinion.urgent;
                              controller.update();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Transform.scale(
                                  scale: 1.5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Radio<Opinion>(
                                        fillColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => controller
                                                            .opinion ==
                                                        Opinion.urgent
                                                    ? primaryColor
                                                    : const Color(0xff698695)),
                                        activeColor: Colors.white,
                                        value: Opinion.urgent,
                                        groupValue: controller.opinion,
                                        onChanged: (value) {
                                          controller.opinion = value!;
                                          controller.update();
                                        }),
                                  ),
                                ),
                                15.horizontalSpace,
                                Text(
                                  "Something urgent happened",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        10.verticalSpace,
                        Divider(
                          thickness: 1,
                        ),
                        GetBuilder<OpinionController>(
                          init: OpinionController(),
                          builder: (controller) => InkWell(
                            onTap: () {
                              controller.opinion = Opinion.wrongAddress;
                              controller.update();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Transform.scale(
                                  scale: 1.5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Radio<Opinion>(
                                        fillColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => controller
                                                            .opinion ==
                                                        Opinion.wrongAddress
                                                    ? primaryColor
                                                    : const Color(0xff698695)),
                                        activeColor: Colors.white,
                                        value: Opinion.wrongAddress,
                                        groupValue: controller.opinion,
                                        onChanged: (value) {
                                          controller.opinion = value!;
                                          controller.update();
                                        }),
                                  ),
                                ),
                                15.horizontalSpace,
                                Text(
                                  "I added wrong address",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        10.verticalSpace,
                        Divider(
                          thickness: 1,
                        ),
                        20.verticalSpace,
                        Container(
                          height: 160.h,
                          width: 360.w,
                          padding: EdgeInsets.only(left: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Color(0xff698695)),
                          ),
                          child: TextField(
                            maxLines: 10,
                            minLines: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              // contentPadding:
                              //     EdgeInsets.symmetric(vertical: 12.5, horizontal: 9.0),
                              hintText: 'Type you cancelling reason here',
                              hintStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                                color: Color(0xFF698695),
                              ),
                            ),
                          ),
                        ),
                        20.verticalSpace,
                        SizedBox(
                          width: 382.w,
                          child: GradientButton(
                            colors: const [
                              Color(0xff698695),
                              Color(0xffa7c5d6)
                            ],
                            text: "Submit and Cancel",
                            onpress: () {
                              Get.back();
                              feedbackSubmited(context: context);
                              // appointmentCanceled(context: context);
                            },
                          ),
                        ),
                        23.verticalSpace,
                        SizedBox(
                          width: 382.w,
                          child: GradientButton(
                            text: "close",
                            onpress: () {
                              Get.back();
                              Get.offAll(
                                () => const HomeScreen(),
                                transition: Transition.rightToLeft,
                                duration: 500.milliseconds,
                              );
                            },
                          ),
                        ),
                        45.verticalSpace,
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    ),
  );
}

Future showWashCanceled<T>({
  required BuildContext context,
  bool allowBackNavigation = true,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    isDismissible: allowBackNavigation,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: WillPopScope(
          onWillPop: () async => allowBackNavigation,
          child: StatefulBuilder(builder: (context, setInnerState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 42.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 110.w,
                        width: 110.w,
                        decoration: BoxDecoration(
                          color: const Color(0xffcbf4df),
                          borderRadius: BorderRadius.circular(55.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 44.w,
                              height: 44.w,
                              decoration: BoxDecoration(
                                color: const Color(0xff39d788),
                                borderRadius: BorderRadius.circular(55.r),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      22.verticalSpace,
                      Text('Your wash has been canceled',
                              style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black))
                          .tr(),
                      10.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.w),
                        child: Text(
                                'Would you like to tell us why you canceled it?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff030303)))
                            .tr(),
                      ),
                      45.verticalSpace,
                      SizedBox(
                        width: 382.w,
                        child: GradientButton(
                          text: "Leave Feedback",
                          onpress: () {
                            Get.back();
                            showOpinionDialog(context: context);
                            // appointmentCanceled(context: context);
                          },
                        ),
                      ),
                      23.verticalSpace,
                      SizedBox(
                        width: 382.w,
                        child: GradientButton(
                          colors: const [Color(0xff698695), Color(0xffa7c5d6)],
                          text: "close",
                          onpress: () {
                            Get.back();
                            Get.offAll(
                              () => const HomeScreen(),
                              transition: Transition.rightToLeft,
                              duration: 500.milliseconds,
                            );
                          },
                        ),
                      ),
                      45.verticalSpace,
                    ],
                  )
                ],
              ),
            );
          }),
        ),
      ),
    ),
  );
}

Future showCancelAppointment<T>({
  required BuildContext context,
  bool allowBackNavigation = true,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    isDismissible: allowBackNavigation,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: WillPopScope(
          onWillPop: () async => allowBackNavigation,
          child: StatefulBuilder(builder: (context, setInnerState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 42.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 110.w,
                        width: 110.w,
                        decoration: BoxDecoration(
                          color: const Color(0xfffff0e6),
                          borderRadius: BorderRadius.circular(55.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.exclamationmark_triangle_fill,
                              color: const Color(0xffff8d41),
                              size: 49.sp,
                            ),
                          ],
                        ),
                      ),
                      22.verticalSpace,
                      Text('cancelappointment',
                              style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black))
                          .tr(),
                      10.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.w),
                        child: Text('nomoney',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff030303)))
                            .tr(),
                      ),
                      45.verticalSpace,
                      SizedBox(
                        width: 382.w,
                        child: GradientButton(
                          colors: const [Color(0xff698695), Color(0xffa7c5d6)],
                          text: "cancelappointment",
                          onpress: () {
                            Get.back();
                            appointmentCanceled(context: context);
                          },
                        ),
                      ),
                      23.verticalSpace,
                      SizedBox(
                        width: 382.w,
                        child: GradientButton(
                          text: "close",
                          onpress: () {
                            Get.back();
                          },
                        ),
                      ),
                      45.verticalSpace,
                    ],
                  )
                ],
              ),
            );
          }),
        ),
      ),
    ),
  );
}

Future showSignOut<T>({
  required BuildContext context,
  bool allowBackNavigation = true,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    isDismissible: allowBackNavigation,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: WillPopScope(
          onWillPop: () async => allowBackNavigation,
          child: StatefulBuilder(builder: (context, setInnerState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 42.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Container(
                      //   height: 110.w,
                      //   width: 110.w,
                      //   decoration: BoxDecoration(
                      //     color: const Color(0xfffff0e6),
                      //     borderRadius: BorderRadius.circular(55.r),
                      //   ),
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Icon(
                      //         CupertinoIcons.exclamationmark_triangle_fill,
                      //         color: const Color(0xffff8d41),
                      //         size: 49.sp,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      22.verticalSpace,
                      Text('Do you want to sign out?',
                              style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black))
                          .tr(),
                      10.verticalSpace,
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 60.w),
                      //   child: Text(
                      //           'Please note that you won\'t get your money back in case of canceling',
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //               fontSize: 15.sp,
                      //               fontWeight: FontWeight.bold,
                      //               color: const Color(0xff030303)))
                      //       .tr(),
                      // ),
                      45.verticalSpace,
                      SizedBox(
                        width: 382.w,
                        child: GradientButton(
                          colors: const [Color(0xff698695), Color(0xffa7c5d6)],
                          text: "Sign Out",
                          onpress: () {
                            FirebaseAuth.instance.signOut();

                            SessionManager().destroy();
                            Get.offAll(() => const VerifyPhoneScreen(),
                                transition: Transition.fadeIn,
                                duration: const Duration(milliseconds: 500));
                            // Get.to(
                            //   () => const WasherFoundScreen(),
                            //   transition: Transition.rightToLeft,
                            //   duration: 500.milliseconds,
                            // );

                            // appointmentCanceled(context: context);
                          },
                        ),
                      ),
                      23.verticalSpace,
                      SizedBox(
                        width: 382.w,
                        child: GradientButton(
                          text: "Cancel",
                          onpress: () {
                            Get.back();
                            // showWashCanceled(context: context);
                          },
                        ),
                      ),
                      45.verticalSpace,
                    ],
                  )
                ],
              ),
            );
          }),
        ),
      ),
    ),
  );
}

Future showCancelWash<T>({
  required BuildContext context,
  bool allowBackNavigation = true,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    isDismissible: allowBackNavigation,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: WillPopScope(
          onWillPop: () async => allowBackNavigation,
          child: StatefulBuilder(builder: (context, setInnerState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 42.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 110.w,
                        width: 110.w,
                        decoration: BoxDecoration(
                          color: const Color(0xfffff0e6),
                          borderRadius: BorderRadius.circular(55.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.exclamationmark_triangle_fill,
                              color: const Color(0xffff8d41),
                              size: 49.sp,
                            ),
                          ],
                        ),
                      ),
                      22.verticalSpace,
                      Text('Do you want to cancel the wash',
                              style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black))
                          .tr(),
                      10.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.w),
                        child: Text(
                                'Please note that you won\'t get your money back in case of canceling',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff030303)))
                            .tr(),
                      ),
                      45.verticalSpace,
                      SizedBox(
                        width: 382.w,
                        child: GradientButton(
                          text: "Don't cancel",
                          onpress: () {
                            // Get.to(
                            //   () => const WasherFoundScreen(),
                            //   transition: Transition.rightToLeft,
                            //   duration: 500.milliseconds,
                            // );
                            Get.back();
                            Get.to(
                              () => const WasherFoundScreen(),
                              transition: Transition.rightToLeft,
                              duration: 500.milliseconds,
                            );
                            // appointmentCanceled(context: context);
                          },
                        ),
                      ),
                      23.verticalSpace,
                      SizedBox(
                        width: 382.w,
                        child: GradientButton(
                          colors: const [Color(0xff698695), Color(0xffa7c5d6)],
                          text: "Cancel Anyway",
                          onpress: () {
                            Get.back();
                            showWashCanceled(context: context);
                          },
                        ),
                      ),
                      45.verticalSpace,
                    ],
                  )
                ],
              ),
            );
          }),
        ),
      ),
    ),
  );
}

Future getreceipt<T>(
    {required BuildContext context, bool allowBackNavigation = false}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    // isDismissible: false,
    // enableDrag: false,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: WillPopScope(
          onWillPop: () async => allowBackNavigation,
          child: StatefulBuilder(builder: (context, setInnerState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 42.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    29.verticalSpace,
                    Text('Get Receipt',
                            style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))
                        .tr(),
                    39.verticalSpace,
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                        child: Column(
                          children: [
                            Row(children: [
                              SvgPicture.asset(
                                  "assets/images/download-icon.svg"),
                              20.horizontalSpace,
                              Text(
                                "Download Receipt",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.sp,
                                    color: Color(0xff10a7f5)),
                              )
                            ]),
                            25.verticalSpace,
                            Row(children: [
                              SvgPicture.asset("assets/images/email-icon.svg"),
                              20.horizontalSpace,
                              InkWell(
                                onTap: () {
                                  Get.back();
                                  receiptSent(context: context);
                                },
                                child: Text(
                                  "Email Receipt",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.sp,
                                      color: Color(0xff10a7f5)),
                                ),
                              )
                            ]),
                          ],
                        )),
                    49.verticalSpace,
                    SizedBox(
                      width: 382.w,
                      child: GradientButton(
                        text: "close",
                        onpress: () {
                          Get.back();

                          final con = Get.put(AppointementController());
                          con.appointmentShow = false;
                          con.update();
                        },
                      ),
                    ),
                    45.verticalSpace,
                  ],
                )
              ],
            );
          }),
        ),
      ),
    ),
  );
}

Future requestSent<T>(
    {required BuildContext context, bool allowBackNavigation = false}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    // isDismissible: false,
    // enableDrag: false,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: WillPopScope(
          onWillPop: () async => allowBackNavigation,
          child: StatefulBuilder(builder: (context, setInnerState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 42.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 110.w,
                      width: 110.w,
                      decoration: BoxDecoration(
                        color: const Color(0xffcbf4df),
                        borderRadius: BorderRadius.circular(55.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 44.w,
                            height: 44.w,
                            decoration: BoxDecoration(
                              color: const Color(0xff39d788),
                              borderRadius: BorderRadius.circular(55.r),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    29.verticalSpace,
                    Text('Your Request Sent',
                            style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))
                        .tr(),
                    10.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48.0.w),
                      child: Center(
                        child: Text('We just sent the request to the washer',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff030303)))
                            .tr(),
                      ),
                    ),
                    49.verticalSpace,
                    SizedBox(
                      width: 382.w,
                      child: GradientButton(
                        text: "close",
                        onpress: () {
                          Get.back();

                          // final con = Get.put(AppointementController());
                          // con.appointmentShow = false;
                          // con.update();
                        },
                      ),
                    ),
                    45.verticalSpace,
                  ],
                )
              ],
            );
          }),
        ),
      ),
    ),
  );
}

Future photoRequested<T>(
    {required BuildContext context, bool allowBackNavigation = false}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    // isDismissible: false,
    // enableDrag: false,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: WillPopScope(
          onWillPop: () async => allowBackNavigation,
          child: StatefulBuilder(builder: (context, setInnerState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 42.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 110.w,
                      width: 110.w,
                      decoration: BoxDecoration(
                        color: const Color(0xffcbf4df),
                        borderRadius: BorderRadius.circular(55.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 44.w,
                            height: 44.w,
                            decoration: BoxDecoration(
                              color: const Color(0xff39d788),
                              borderRadius: BorderRadius.circular(55.r),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    29.verticalSpace,
                    Text('Photo Requested',
                            style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))
                        .tr(),
                    10.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48.0.w),
                      child: Center(
                        child: Text(
                                'We will notify you once washer sends you a photo of your washed car',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff030303)))
                            .tr(),
                      ),
                    ),
                    49.verticalSpace,
                    SizedBox(
                      width: 382.w,
                      child: GradientButton(
                        text: "close",
                        onpress: () {
                          Get.back();

                          // final con = Get.put(AppointementController());
                          // con.appointmentShow = false;
                          // con.update();
                        },
                      ),
                    ),
                    45.verticalSpace,
                  ],
                )
              ],
            );
          }),
        ),
      ),
    ),
  );
}

Future feedbackSubmited<T>(
    {required BuildContext context, bool allowBackNavigation = false}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    // isDismissible: false,
    // enableDrag: false,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: WillPopScope(
          onWillPop: () async => allowBackNavigation,
          child: StatefulBuilder(builder: (context, setInnerState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 42.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 110.w,
                      width: 110.w,
                      decoration: BoxDecoration(
                        color: const Color(0xffcbf4df),
                        borderRadius: BorderRadius.circular(55.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 44.w,
                            height: 44.w,
                            decoration: BoxDecoration(
                              color: const Color(0xff39d788),
                              borderRadius: BorderRadius.circular(55.r),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    29.verticalSpace,
                    Text('Thanks for your feedback!',
                            style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))
                        .tr(),
                    10.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48.0.w),
                      child: Center(
                        child: Text(
                                'We\'re doing our best to provide the best customer experience',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff030303)))
                            .tr(),
                      ),
                    ),
                    49.verticalSpace,
                    SizedBox(
                      width: 382.w,
                      child: GradientButton(
                        text: "close",
                        onpress: () {
                          Get.back();

                          Get.offAll(
                            () => const HomeScreen(),
                            transition: Transition.rightToLeft,
                            duration: 500.milliseconds,
                          );
                        },
                      ),
                    ),
                    45.verticalSpace,
                  ],
                )
              ],
            );
          }),
        ),
      ),
    ),
  );
}

Future receiptSent<T>(
    {required BuildContext context, bool allowBackNavigation = false}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    // isDismissible: false,
    // enableDrag: false,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: WillPopScope(
          onWillPop: () async => allowBackNavigation,
          child: StatefulBuilder(builder: (context, setInnerState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 42.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 110.w,
                      width: 110.w,
                      decoration: BoxDecoration(
                        color: const Color(0xffcbf4df),
                        borderRadius: BorderRadius.circular(55.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 44.w,
                            height: 44.w,
                            decoration: BoxDecoration(
                              color: const Color(0xff39d788),
                              borderRadius: BorderRadius.circular(55.r),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    29.verticalSpace,
                    Text('Receipt Sent',
                            style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))
                        .tr(),
                    10.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48.0.w),
                      child: Center(
                        child: Text(
                                'We just sent you the receipt to:ahmed23@gmail.com',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff030303)))
                            .tr(),
                      ),
                    ),
                    49.verticalSpace,
                    SizedBox(
                      width: 382.w,
                      child: GradientButton(
                        text: "close",
                        onpress: () {
                          Get.back();

                          final con = Get.put(AppointementController());
                          con.appointmentShow = false;
                          con.update();
                        },
                      ),
                    ),
                    45.verticalSpace,
                  ],
                )
              ],
            );
          }),
        ),
      ),
    ),
  );
}

Future appointmentCanceled<T>(
    {required BuildContext context, bool allowBackNavigation = false}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    // isDismissible: false,
    // enableDrag: false,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: WillPopScope(
          onWillPop: () async => allowBackNavigation,
          child: StatefulBuilder(builder: (context, setInnerState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 42.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 110.w,
                      width: 110.w,
                      decoration: BoxDecoration(
                        color: const Color(0xffcbf4df),
                        borderRadius: BorderRadius.circular(55.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 44.w,
                            height: 44.w,
                            decoration: BoxDecoration(
                              color: const Color(0xff39d788),
                              borderRadius: BorderRadius.circular(55.r),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    29.verticalSpace,
                    Text('appointmentcancelled',
                            style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))
                        .tr(),
                    10.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48.0.w),
                      child: Center(
                        child: Text('wejustcancelled',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff030303)))
                            .tr(),
                      ),
                    ),
                    49.verticalSpace,
                    SizedBox(
                      width: 382.w,
                      child: GradientButton(
                        text: "close",
                        onpress: () {
                          Get.back();

                          final con = Get.put(AppointementController());
                          con.appointmentShow = false;
                          con.update();
                        },
                      ),
                    ),
                    45.verticalSpace,
                  ],
                )
              ],
            );
          }),
        ),
      ),
    ),
  );
}

class ChargeMethode extends StatelessWidget {
  Widget? icon;
  String? paymentType;
  ChargeMethode({
    Key? key,
    this.icon,
    this.paymentType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 382.w,
      height: 97.h,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon!,
            20.horizontalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(paymentType!), const Text("number")],
                ),
                170.horizontalSpace,
                Icon(
                  Icons.arrow_forward_ios,
                  color: const Color(0xff313131),
                  size: 16.sp,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
