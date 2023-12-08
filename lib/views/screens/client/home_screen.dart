import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:washly/controllers/client/appoitment_controller.dart';
import 'package:washly/controllers/client/home_controller.dart';
import 'package:washly/utils/buttons.dart';
import 'package:washly/utils/constants.dart';

import '../../../controllers/client/cars_list_controller.dart';
import 'add_car_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: controller.currentIndex == 1
                ? GetBuilder<CarsListController>(
                    init: CarsListController(),
                    builder: (controller) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 100.0.h),
                        child: SizedBox(
                          width: 382.w,
                          height: 67.h,
                          child: GradientButton(
                            text: controller.carShow ? 'washcar' : 'addcar',
                            onpress: () {
                              controller.carShow
                                  ? null
                                  : Get.to(() => const AddCarScreen(),
                                      transition:
                                          Transition.rightToLeftWithFade,
                                      arguments: [controller.user],
                                      duration:
                                          const Duration(milliseconds: 500));
                            },
                          ),
                        ),
                      );
                    })
                : controller.currentIndex == 2
                    ? GetBuilder<AppointementController>(
                        init: AppointementController(),
                        builder: (controller) {
                          return !controller.appointmentShow
                              ? Padding(
                                  padding: EdgeInsets.only(bottom: 100.0.h),
                                  child: SizedBox(
                                    width: 382.w,
                                    height: 67.h,
                                    child: GradientButton(
                                      text: 'schedulewash',
                                      onpress: () {
                                        final cont = Get.put(HomeController());
                                        print("${cont.currentIndex}");
                                        cont.changeScreen(0);
                                        cont.update();
                                      },
                                    ),
                                  ),
                                )
                              : Container();
                        })
                    : null,
            backgroundColor: greyColor,
            body: controller.isLoading.value
                ? Center(
                    child: SpinKitDoubleBounce(
                    color: primaryColor,
                    size: 50.0.sp,
                  ))
                : SingleChildScrollView(child: controller.currentScreen),
            bottomNavigationBar: Container(
              // height: 80.h,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14.r),
                    topRight: Radius.circular(14.r)),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  selectedItemColor: primaryColor,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  unselectedItemColor: Colors.grey.withOpacity(0.4),
                  currentIndex: controller.currentIndex,
                  onTap: (index) {
                    controller.changeScreen(index);
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset('assets/images/home-icon.svg',
                            color: controller.currentIndex == 0
                                ? primaryColor
                                : null,
                            height: 26.h,
                            fit: BoxFit.cover),
                        label: tr('home')),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset('assets/images/cars-icon.svg',
                            color: controller.currentIndex == 1
                                ? primaryColor
                                : null,
                            height: 25.h,
                            fit: BoxFit.cover),
                        label: 'cars'),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                            'assets/images/appointments-icon.svg',
                            color: controller.currentIndex == 2
                                ? primaryColor
                                : null,
                            height: 25.h,
                            fit: BoxFit.cover),
                        label: 'booking'),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset('assets/images/account-icon.svg',
                            color: controller.currentIndex == 3
                                ? primaryColor
                                : null,
                            height: 25.h,
                            fit: BoxFit.cover),
                        label: 'profile'),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
