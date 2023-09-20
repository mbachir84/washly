import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:washly/controllers/client/profile_controller.dart';
import 'package:washly/utils/constants.dart';
import 'package:washly/views/screens/client/edit_profile_screen.dart';

class ProfileInformationWidget extends StatelessWidget {
  const ProfileInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                69.verticalSpace,
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: controller.user!.profileImage ??
                          "https://static.cnews.fr/sites/default/files/karim_benzema_les_images_de_son_premier_entrainement_avec_son_nouveau_club_en_arabie_saoudite_video_64ad533b7903b.jpg",
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      imageBuilder: (context, imageProvider) => Container(
                        height: 62.w,
                        width: 62.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            controller.loading
                                ? ""
                                : controller.user!.fullname!,
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold)),
                        TextButton(
                          onPressed: () =>
                              Get.to(() => const EditProfileScreen()),
                          child: Text("editProfile",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: primaryColor))
                              .tr(),
                        ),
                      ],
                    )
                  ],
                ),
                20.verticalSpace,
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: primaryColor,
                    ),
                    10.horizontalSpace,
                    Text("2,5 Rating",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
                10.verticalSpace,
              ],
            ),
          );
        });
  }
}
