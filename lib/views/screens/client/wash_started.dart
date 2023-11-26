import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:washly/controllers/client/washer_found_controller.dart';

class WashStartedScreen
 extends StatelessWidget {
  const WashStartedScreen
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<WasherFoundController>(
            init: WasherFoundController(),
            builder: (controller) {
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        transform: GradientRotation(1.5708),
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff009bfd),
                          Color(0xff6ce7c3),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      70.verticalSpace,
                      Text("The Wash Started",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w900))
                          .tr(),
                      30.verticalSpace,
                      Center(
                        child: SpinKitDoubleBounce(
                          color: Colors.white,
                          size: 300.0.sp,
                        ),
                      ),
                    ],
                  )
                ],
              );
            }));
  }
}