import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:washly/controllers/client/profile_controller.dart';
import 'package:washly/views/screens/loading_widget.dart';
import 'package:washly/widgets/profile_widget/profile_information_widget.dart';
import 'package:washly/widgets/profile_widget/profile_item_menu_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 922.h,
      child: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (controller) {
            return controller.loading
                ? LoadingWidget()
                : const Column(
                    children: [
                      ProfileInformationWidget(),
                      ProfileItemMenuWidget()
                    ],
                  );
          }),
    );
  }
}
