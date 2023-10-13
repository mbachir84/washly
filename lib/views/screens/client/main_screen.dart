import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:washly/controllers/client/addresses_list_controller.dart';
import 'package:washly/controllers/client/choose_car_controller.dart';
import 'package:washly/controllers/client/home_controller.dart';
import 'package:washly/utils/buttons.dart';
import 'package:washly/utils/constants.dart';
import 'package:washly/utils/glassmorphism.dart';
import 'package:washly/views/screens/client/addresses_list_screen.dart';
import 'package:washly/views/screens/client/choose_address_screen.dart';
import 'package:washly/views/screens/client/choose_car_screen.dart';
import 'package:washly/views/screens/client/notifications_screen.dart';
import 'package:washly/views/screens/client/select_address.dart';

import '../../../controllers/client/main_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  // var addressController = Get.put(() => AddAddressController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1.sh,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            primaryColor,
            secondaryColor,
          ])),
      child: Stack(
        children: [
          // SvgPicture.asset('assets/images/w-background.svg', fit: BoxFit.cover),
          Column(
            children: [
              57.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/images/wallet.svg', width: 23.3.w),
                    12.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'walletbalance',
                          style: TextStyle(
                              color: const Color(0xffaedaf1),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ).tr(),
                        5.verticalSpace,
                        Text(
                          '500 MAD',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ).tr(),
                      ],
                    ),
                    const Spacer(),
                    Glassmorphism(
                      blur: 80,
                      opacity: 0.2,
                      radius: 90.r,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 51.w,
                            height: 51.w,
                            child: InkWell(
                              onTap: () =>Get.to(()=> NotificationScreen()),
                              child: Icon(CupertinoIcons.bell,
                                  color: Colors.white, size: 30.sp),
                            ),
                          ),
                          Positioned(
                            top: 14.h,
                            left: 14.w,
                            child: Container(
                              width: 12.w,
                              height: 12.w,
                              decoration: BoxDecoration(
                                  color: const Color(0xff7cfeff),
                                  borderRadius: BorderRadius.circular(100.r)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              34.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Container(
                  height: 91.h,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(color: Color(0x1a000000), blurRadius: 5)
                      ],
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xff3fc0ff),
                            Color(0xff51d4d2),
                          ]),
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Stack(
                    children: [
                      Image.asset('assets/images/w-banner.png',
                          fit: BoxFit.cover),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('savewashes',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold))
                                  .tr(),
                              Text(plural('earnto', 0, args: ['40']),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold))
                                  .tr(),
                            ],
                          ),
                          SizedBox(
                            width: 123.w,
                            height: 41.h,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r))),
                                onPressed: () {},
                                child: Text(
                                  'invitefriend',
                                  style: TextStyle(
                                      color: const Color(0xff030303),
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold),
                                ).tr()),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              23.verticalSpace,
              GetBuilder<MainController>(
                  init: MainController(),
                  builder: (controller) {
                    return controller.isLoading.value
                        ? Center(
                            child: SpinKitDoubleBounce(
                              color: Colors.white,
                              size: 70.0.sp,
                            ),
                          )
                        : Expanded(
                            child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: greyColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40.r),
                                    topRight: Radius.circular(40.r),
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 24.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      26.verticalSpace,
                                      Text(
                                        'selectwash',
                                        style: TextStyle(
                                            color: titleColor,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600),
                                      ).tr(),
                                      12.verticalSpace,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              controller.washType =
                                                  (WashType.basic);
                                              controller.update();
                                            },
                                            child: Container(
                                                width: 184.w,
                                                height: 94.h,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      width: 3.w,
                                                      color: controller
                                                                  .washType ==
                                                              WashType.basic
                                                          ? const Color(
                                                              0xff10a7f5)
                                                          : Colors.transparent,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9.r),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color:
                                                              Color(0x1a000000),
                                                          blurRadius: 5),
                                                    ]),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 16,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text('basicwash',
                                                                  style: TextStyle(
                                                                      color: const Color(
                                                                          0xff030303),
                                                                      fontSize:
                                                                          16.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold))
                                                              .tr(),
                                                          4.verticalSpace,
                                                          Text('startsfrom',
                                                              style: TextStyle(
                                                                color:
                                                                    titleColor,
                                                                fontSize: 11.sp,
                                                              )).tr(),
                                                          Text('20 MAD',
                                                              style: TextStyle(
                                                                  color: const Color(
                                                                      0xff030303),
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                      Radio<WashType>(
                                                          fillColor:
                                                              MaterialStateColor
                                                                  .resolveWith(
                                                            (states) => controller
                                                                        .washType !=
                                                                    WashType
                                                                        .basic
                                                                ? titleColor
                                                                : const Color(
                                                                    0xFF10a7f5),
                                                          ),
                                                          activeColor:
                                                              Colors.white,
                                                          value: WashType.basic,
                                                          groupValue: controller
                                                              .washType,
                                                          onChanged: (value) {
                                                            controller
                                                                    .washType =
                                                                value!;
                                                            controller.update();
                                                          }),
                                                    ],
                                                  ),
                                                )),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              controller.washType =
                                                  (WashType.full);
                                              controller.update();
                                            },
                                            child: Container(
                                                width: 184.w,
                                                height: 94.h,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      width: 3.w,
                                                      color: controller
                                                                  .washType ==
                                                              WashType.full
                                                          ? const Color(
                                                              0xff10a7f5)
                                                          : Colors.transparent,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9.r),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color:
                                                              Color(0x1a000000),
                                                          blurRadius: 5)
                                                    ]),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 16,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text('Full Wash',
                                                              style: TextStyle(
                                                                  color: const Color(
                                                                      0xff030303),
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          4.verticalSpace,
                                                          Text('startsfrom',
                                                              style: TextStyle(
                                                                color:
                                                                    titleColor,
                                                                fontSize: 11.sp,
                                                              )).tr(),
                                                          Text('40 MAD',
                                                              style: TextStyle(
                                                                  color: const Color(
                                                                      0xff030303),
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                      Radio<WashType>(
                                                          fillColor:
                                                              MaterialStateColor
                                                                  .resolveWith(
                                                            (states) => controller
                                                                        .washType !=
                                                                    WashType
                                                                        .full
                                                                ? titleColor
                                                                : const Color(
                                                                    0xFF10a7f5),
                                                          ),
                                                          activeColor:
                                                              Colors.white,
                                                          value: WashType.full,
                                                          groupValue: controller
                                                              .washType,
                                                          onChanged: (value) {
                                                            controller
                                                                    .washType =
                                                                value!;
                                                            controller.update();
                                                          }),
                                                    ],
                                                  ),
                                                )),
                                          )
                                        ],
                                      ),
                                      15.verticalSpace,
                                      InkWell(
                                        onTap: () {
                                          controller.washType =
                                              (WashType.premium);
                                          controller.update();
                                        },
                                        child: Container(
                                            height: 94.h,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  width: 3.w,
                                                  color: controller.washType ==
                                                          WashType.premium
                                                      ? const Color(0xff10a7f5)
                                                      : Colors.transparent,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(9.r),
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: Color(0x1a000000),
                                                      blurRadius: 5)
                                                ]),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 16,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text('Premium Wash',
                                                          style: TextStyle(
                                                              color: const Color(
                                                                  0xff030303),
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      4.verticalSpace,
                                                      Text('startsfrom',
                                                          style: TextStyle(
                                                            color: titleColor,
                                                            fontSize: 11.sp,
                                                          )).tr(),
                                                      Text('40 MAD',
                                                          style: TextStyle(
                                                              color: const Color(
                                                                  0xff030303),
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                  Radio<WashType>(
                                                      fillColor:
                                                          MaterialStateColor
                                                              .resolveWith(
                                                        (states) => controller
                                                                    .washType !=
                                                                WashType.premium
                                                            ? titleColor
                                                            : const Color(
                                                                0xFF10a7f5),
                                                      ),
                                                      value: WashType.premium,
                                                      groupValue:
                                                          controller.washType,
                                                      onChanged: (value) {
                                                        controller.washType =
                                                            value!;
                                                        controller.update();
                                                      }),
                                                ],
                                              ),
                                            )),
                                      ),
                                      20.verticalSpace,
                                      Text(
                                        'selectcar',
                                        style: TextStyle(
                                            color: titleColor,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600),
                                      ).tr(),
                                      10.verticalSpace,
                                      InkWell(
                                        onTap: () {
                                          // final homeController =
                                          //     Get.put(HomeController());
                                          // homeController.changeScreen(1);
                                          Get.to(ChooseCarScreen());
                                        },
                                        child: GetBuilder<ChooseCarController>(
                                          init: ChooseCarController(),
                                          builder: (contr) => 
                                          Container(
                                              height: 70.h,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(9.r),
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: Color(0x1a000000),
                                                      blurRadius: 5)
                                                ],
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 19.w),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        'assets/images/car-select-icon.svg',
                                                        height: 42.h,
                                                        width: 42.w,
                                                        fit: BoxFit.cover),
                                                    10.horizontalSpace,
                                                    controller
                                                            .user.cars.isNotEmpty
                                                        ? Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(                                                         
                                                                contr
                                                                    .selectedCar
                                                                    .make!,
                                                                style: TextStyle(
                                                                    color: const Color(
                                                                        0xff313131),
                                                                    fontSize:
                                                                        16.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              4.verticalSpace,
                                                              Text(
                                                                contr.selectedCar
                                                                    .licencePlate!,
                                                                style: TextStyle(
                                                                  color:
                                                                      titleColor,
                                                                  fontSize: 13.sp,
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : Text(
                                                            'Select Car',
                                                            style: TextStyle(
                                                                color: const Color(
                                                                    0xff313131),
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ).tr(),
                                                    const Spacer(),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      color:
                                                          const Color(0xff313131),
                                                      size: 16.sp,
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ),
                                      16.verticalSpace,
                                      Text(
                                        'selectaddress',
                                        style: TextStyle(
                                            color: titleColor,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600),
                                      ).tr(),
                                      10.verticalSpace,
                                      InkWell(
                                        onTap: () {
                                          Get.to(
                                              () => const ChosseAddressScreen(),
                                              transition: Transition
                                                  .leftToRightWithFade,
                                              duration: const Duration(
                                                  milliseconds: 500));
                                        },
                                        child: Container(
                                            height: 70.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(9.r),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Color(0x1a000000),
                                                    blurRadius: 5)
                                              ],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 19.w),
                                              child: GetBuilder<
                                                  AddressesListController>(
                                                init: AddressesListController(),
                                                builder: (cont) => Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        'assets/images/location-select-icon.svg',
                                                        height: 42.h,
                                                        width: 42.w,
                                                        fit: BoxFit.cover),
                                                    10.horizontalSpace,
                                                    cont.selectedAddress != null
                                                        ? Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                cont.selectedAddress.name!,
                                                              
                                                                style: TextStyle(
                                                                    color: const Color(
                                                                        0xff313131),
                                                                    fontSize:
                                                                        16.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              4.verticalSpace,
                                                              SizedBox(
                                                                width: 200.w,
                                                                child: Text(
                                                                  cont.selectedAddress.description!,
                                                                  
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 1,
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        titleColor,
                                                                    fontSize:
                                                                        13.sp,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : Text(
                                                            'Select address',
                                                            style: TextStyle(
                                                                color: const Color(
                                                                    0xff313131),
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ).tr(),
                                                    const Spacer(),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: const Color(
                                                          0xff313131),
                                                      size: 16.sp,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )),
                                      ),
                                      26.verticalSpace,
                                      GradientButton(
                                        allowed: controller.user.cars.isEmpty ||
                                                controller
                                                    .user.addresses!.isEmpty
                                            ? false
                                            : true,
                                        text: 'next',
                                        onpress: () {
                                          controller.showDialog(context);
                                        },
                                      ),
                                    ],
                                  ),
                                )),
                          );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
