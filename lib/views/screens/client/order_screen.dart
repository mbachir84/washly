import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:washly/controllers/client/order_controller.dart';
import 'package:washly/utils/constants.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<OrderController>(
            init: OrderController(),
            builder: (controller) {
              return InkWell(
                onTap: () {
                  controller.showBottomDialog(context);
                },
                child: Stack(
                  children: [
                    Image.asset('assets/images/mapholder.jpeg',
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover),
                    Column(
                      children: [
                        260.verticalSpace,
                        SpinKitDoubleBounce(
                          color: primaryColor,
                          size: 100.0.sp,
                        ),
                        80.verticalSpace,
                        Text("lookingforwasher",
                                style: TextStyle(
                                    color: const Color(0xff030303),
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w900))
                            .tr(),
                        11.verticalSpace,
                        Text("seatrelax",
                                style: TextStyle(
                                    color: const Color(0xff030303),
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w600))
                            .tr(),
                        11.verticalSpace,
                      ],
                    )
                  ],
                ),
              );
            }));
  }
}
