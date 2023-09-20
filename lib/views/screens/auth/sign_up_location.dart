import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; 
import 'package:washly/utils/buttons.dart';
import 'package:washly/utils/constants.dart';
import 'package:washly/utils/glassmorphism.dart';
import 'package:washly/views/screens/loading_widget.dart';

import '../../../controllers/auth/sign_up_location_controller.dart';
 

class SignUpLocation extends StatelessWidget {
  const SignUpLocation({super.key});

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
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 29.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              84.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 5.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2.5.r)),
                  ),
                  Container(
                    height: 5.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(2.5.r)),
                  ),
                  Container(
                    height: 5.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(2.5.r)),
                  ),
                  Container(
                    height: 5.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(2.5.r)),
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
                  child: Icon(Icons.location_on_rounded,
                      color: Colors.white, size: 30.sp),
                ),
              ),
              15.verticalSpace,
              Text(
                'setyourlocation',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold),
              ).tr(),
              12.verticalSpace,
              Text(
                'weuse',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
              ).tr(),
              33.verticalSpace,
              GetBuilder<SignUpLocationController>(
                  init: SignUpLocationController(),
                  builder: (controller) {
                    return SizedBox(
                        width: 372.w,
                        height: 342.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: controller.isLoading.value
                              ? LoadingWidget()
                              : controller.mapCreated
                                  ? GoogleMap(
                                      mapType: MapType.normal,
                                      myLocationButtonEnabled: true,
                                      zoomControlsEnabled: false,
                                      myLocationEnabled: true,
                                      initialCameraPosition: CameraPosition(
                                      target: controller.location!,
                                        zoom: 17.4746,
                                      ),
                                    )
                                  : Container(
                                      width: 372.w,
                                      height: 342.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          color: Colors.white),
                                      child: Image.asset(
                                        'assets/images/mapholder.jpeg',
                                        fit: BoxFit.cover,
                                      )),
                        ));
                  }),
              58.verticalSpace,
              Center(
                child: SizedBox(
                    width: 356.w,
                    child: GetBuilder<SignUpLocationController>(
                        init: SignUpLocationController(),
                        builder: (controller) {
                          return PrimaryButton(
                              text: controller.mapCreated
                                  ? 'next'
                                  : 'setlocation',
                              onpress: () {
                                controller.mapCreated
                                    ? controller.submit()
                                    : controller.handlePermissions();
                              });
                        })),
              ),
              43.verticalSpace,
              GetBuilder<SignUpLocationController>(
                  init: SignUpLocationController(),
                  builder: (controller) {
                    return InkWell(
                      onTap: () {
                        controller.skip();
                      },
                      child: Center(
                        child: Text(
                          'skiplater',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.bold),
                        ).tr(),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    ));
  }
}
