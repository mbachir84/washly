import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:washly/controllers/client/addresses_list_controller.dart';
import 'package:washly/utils/buttons.dart';
import 'package:washly/utils/constants.dart';
import 'package:washly/views/components/widgets.dart';
import 'package:washly/views/screens/client/add_address_screen.dart';
import 'package:washly/views/screens/client/edit_address_screen.dart';

class AddressesListScreen extends StatelessWidget {
  const AddressesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          padding: EdgeInsets.all(24.0.w),
          child: GradientButton(
            text: 'addnewaddress',
            onpress: () {
              Get.to(
                () => const AddAddressScreen(),
                duration: const Duration(milliseconds: 500),
                transition: Transition.rightToLeftWithFade,
              );
            },
          ),
        ),
        backgroundColor: const Color(0xffeaeff0), 
        
        body: SingleChildScrollView(
          child: GetBuilder<AddressesListController>(
              init: AddressesListController(),
              builder: (controller) {
                return Stack(
                  children: [
                    Padding(
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
                                'addresses',
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    color: const Color(0xff030303),
                                    fontWeight: FontWeight.bold),
                              ).tr(),
                            ],
                          ),
                          28.verticalSpace,
                          controller.isLoading.value
                              ? Center(
                                  child: SpinKitDoubleBounce(
                                  color: primaryColor,
                                  size: 50.0.sp,
                                ))
                              : SizedBox(
                                  height: 1.sh - 200.h,
                                  child: ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            Column(
                                      children: [
                                        Center(
                                            child: InkWell(
                                          onTap: () {
                                            print(controller
                                                .user.addresses!.reversed
                                                .toList()[index]
                                                .description!);
                                            Get.to(() => const EditAddressScreen(),
                                                transition: Transition.fadeIn,
                                                duration: const Duration(
                                                    milliseconds: 500), arguments: controller
                                                .user.addresses!.reversed
                                                .toList()[index]);
                                          },
                                          child: Container(
                                            height: 118.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.transparent,
                                                    width: 2.w),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15.0.w),
                                              child: Row(
                                                children: [
                                                  28.horizontalSpace,
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            controller
                                                                .user
                                                                .addresses!
                                                                .reversed
                                                                .toList()[index]
                                                                .name!,
                                                            style: TextStyle(
                                                                fontSize: 16.sp,
                                                                color:
                                                                    darkColor2,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          100.horizontalSpace,
                                                          controller
                                                                  .user
                                                                  .addresses!
                                                                  .reversed
                                                                  .toList()[
                                                                      index]
                                                                  .isDefault!
                                                              ? Container(
                                                                  width: 106.w,
                                                                  height: 20.h,
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          primaryColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              9.r)),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "defaultaddress",
                                                                      style: TextStyle(
                                                                          fontSize: 10
                                                                              .sp,
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ).tr(),
                                                                  ))
                                                              : Container(),
                                                        ],
                                                      ),
                                                      5.verticalSpace,
                                                      SizedBox(
                                                        width: 150.w,
                                                        child: Text(
                                                          controller
                                                              .user
                                                              .addresses!
                                                              .reversed
                                                              .toList()[index]
                                                              .description!,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontSize: 15.sp,
                                                              color: titleColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                      5.verticalSpace,
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: const Color(0xff313131),
                                                    size: 16.sp,
                                                    // weight: 22,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )),
                                        index !=
                                                controller.user.addresses!
                                                        .length -
                                                    1
                                            ? Container()
                                            : 100.verticalSpace,
                                      ],
                                    ),
                                    itemCount:
                                        controller.user.addresses!.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            10.verticalSpace,
                                  ),
                                )
                        ],
                      ),
                    ),
                    AnimatedSnackbar(
                        height: controller.height,
                        title: controller.snackBarTitle,
                        subtitle: controller.snackBarSubTitle,
                        state: controller.state),
                  ],
                );
              }),
        ));
  }
}
