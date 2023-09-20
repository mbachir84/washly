import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:washly/controllers/client/add_address_controller.dart';
import 'package:washly/utils/buttons.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:washly/utils/constants.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        child: GetBuilder<AddAddressController>(
            init: AddAddressController(),
            builder: (controller) {
              return GradientButton(
                loading: controller.loading.value,
                allowed: controller.allowed,
                text: "saveaddress",
                onpress: () {
                  controller.submit();
                },
              );
            }),
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<AddAddressController>(
          init: AddAddressController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    85.verticalSpace,
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
                          'addnewaddresswith',
                          style: TextStyle(
                              fontSize: 22.sp,
                              color: const Color(0xff030303),
                              fontWeight: FontWeight.bold),
                        ).tr(),
                        const Spacer(),
                        TextButton(
                            onPressed: () {},
                            child: Text('cancel',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold))
                                .tr()),
                      ],
                    ),
                    35.verticalSpace,
                    Text('locationname',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff698695)))
                        .tr(),
                    12.verticalSpace,
                    SizedBox(
                      width: double.infinity,
                      height: 54.h,
                      child: TextField(
                        autofocus: true,
                        controller: controller.locationNameController,
                        onChanged: (value) {
                          controller.suffixIconEnabled = value.isNotEmpty;
                          controller.verify();
                          controller.update();
                        },
                        decoration: InputDecoration(
                            suffixIcon: controller.suffixIconEnabled
                                ? InkWell(
                                    onTap: () {
                                      controller.suffixIconEnabled = false;
                                      controller.locationNameController.clear();
                                      controller.verify();
                                      controller.update();
                                    },
                                    child: Icon(
                                      CupertinoIcons.xmark_circle_fill,
                                      color: Colors.grey.withOpacity(0.5),
                                      size: 24.w,
                                    ),
                                  )
                                : null,
                            hintStyle: TextStyle(
                                color: const Color(0xff698695),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.r),
                                borderSide: BorderSide(
                                    color: const Color(0xff698695), width: 1.w)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.r),
                                borderSide: BorderSide(
                                    color: const Color(0xff698695), width: 1.w))),
                      ),
                    ),
                    35.verticalSpace,
                    Text('searchtheaddress',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff698695)))
                        .tr(),
                    12.verticalSpace,
                    Container(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(
                        minHeight: 54.h,
                      ),
                      width: double.infinity.w,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff030303),
                        ),
                        controller: controller.addressSearch,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                          ),
                          suffixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 34.h,
                                width: 34.h,
                                child: SvgPicture.asset(
                                  "assets/images/location-select-icon.svg",
                                ),
                              ),
                            ],
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.w,
                              color: const Color(0xff698695),
                            ),
                          ),
                          isDense: true,
                          hintText: '',
                          filled: true,
                          fillColor: Colors.transparent,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2.w, color: primaryColor),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (value) {
                          if (controller.debounce?.isActive ?? false) {
                            controller.debounce!.cancel();
                          }
                          controller.verify();
                          controller.debounce =
                              Timer(const Duration(milliseconds: 300), () {
                            if (value.isNotEmpty) {
                              controller.endContainer = true;
                              controller.autoCompleteSearch(value);
                            } else {
                              controller.endContainer = false;
                              controller.predictions = [];
                              controller.update();
                            }
                          });
                        },
                      ),
                    ),
                    3.verticalSpace,
                    controller.endContainer
                        ? Container(
                            constraints: BoxConstraints(
                              maxHeight: 213.h,
                            ),
                            width: double.infinity.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: primaryColor, width: 2.w),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return Divider(
                                  height: 1.h,
                                  color: const Color(0xffd8e7fa),
                                );
                              },
                              padding: EdgeInsets.zero,
                              itemCount: controller.predictions.length,
                              itemBuilder: (index, i) {
                                return InkWell(
                                  onTap: () async {
                                    controller.addressSearch.text =
                                        controller.predictions[i].description!;
                                    List<geo.Location> locations =
                                        await geo.locationFromAddress(
                                            controller
                                                .predictions[i].description!,
                                            localeIdentifier: "fr_FR");
                                    controller.address.latitude =
                                        locations.first.latitude;

                                    controller.address.longitude =
                                        locations.first.longitude;
                                    controller.endContainer = false;
                                    controller.verify();
                                    controller.update();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 23.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 50.h,
                                          width: double.infinity.w,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.predictions[i]
                                                    .description!,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(),
                    36.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FlutterSwitch(
                          width: 57.0.w,
                          height: 34.h,
                          value: controller.switchValue,
                          borderRadius: 17.0.r,
                          onToggle: (val) {
                            controller.switchValue = val;
                            controller.submit();
                          },
                        ),
                        19.horizontalSpace,
                        Text(
                          'defaultaddress',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff030303)),
                        ).tr(),
                      ],
                    ),
                    20.verticalSpace,
                    Container(
                      height: 53.h,
                      width: double.infinity.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: primaryColor.withOpacity(0.12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/info-icon.svg",
                          ),
                          10.horizontalSpace,
                          SizedBox(
                            width: 295.w,
                            child: Text(
                              'onlyoneaddress',
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor),
                            ).tr(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
