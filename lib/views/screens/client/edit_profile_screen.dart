import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:washly/controllers/client/edit_profile_controller.dart';
import 'package:washly/utils/constants.dart';

import '../../../utils/buttons.dart';
import '../../../widgets/add_coupons_widget/text_field_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeaeff0),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: GetBuilder<EditProfileController>(
            init: EditProfileController(),
            builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GradientButton(
                    loading: controller.isLoading,
                    allowed: controller.isVerified,
                    text: "save",
                    onpress: () {
                      controller.updateProfile();
                      // print('all');
                      // controller.submit();
                    },
                  ),
                ],
              );
            }),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: GetBuilder<EditProfileController>(
              init: EditProfileController(),
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    85.verticalSpace,
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: SvgPicture.asset(
                              'assets/images/arrow-back.svg',
                              height: 9.h,
                              width: 17,
                            )),
                        9.horizontalSpace,
                        Text(
                          'editprofile',
                          style: TextStyle(
                            fontSize: 22.sp,
                            color: const Color(0xff030303),
                            fontWeight: FontWeight.bold,
                          ),
                        ).tr(),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'cancel',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ).tr())
                      ],
                    ),
                    50.verticalSpace,
                    Center(
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(500),
                            child: controller.image != null
                                ? Image.file(
                                    File(controller.image!.path),
                                    height: 134.w,
                                    width: 134.w,
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: controller.isLoading
                                        ? "https://static.cnews.fr/sites/default/files/karim_benzema_les_images_de_son_premier_entrainement_avec_son_nouveau_club_en_arabie_saoudite_video_64ad533b7903b.jpg"
                                        : controller.user!.profileImage ??
                                            "https://static.cnews.fr/sites/default/files/karim_benzema_les_images_de_son_premier_entrainement_avec_son_nouveau_club_en_arabie_saoudite_video_64ad533b7903b.jpg",
                                    placeholder: (context, url) => SizedBox(
                                        height: 134.w,
                                        width: 134.w,
                                        child: const CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        SizedBox(
                                            height: 134.w,
                                            width: 134.w,
                                            child: const Icon(Icons.error)),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height: 134.w,
                                      width: 134.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                          Positioned(
                              bottom: 2.h,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  controller.pickImage();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5.h),
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffeaeff0),
                                  ),
                                  child: Container(
                                      padding: EdgeInsets.all(8.h),
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: primaryColor,
                                      ),
                                      child: Icon(
                                        CupertinoIcons.camera,
                                        size: 22.sp,
                                        color: Colors.white,
                                      )),
                                ),
                              ))
                        ],
                      ),
                    ),
                    50.verticalSpace,
                    Text(
                      'fname',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(),
                    15.verticalSpace,
                    TextFieldWidget(
                      controller: controller.nameController,
                    ),
                    30.verticalSpace,
                    Text(
                      'email',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(),
                    15.verticalSpace,
                    TextFieldWidget(
                      controller: controller.emailController,
                    ),
                    30.verticalSpace,
                    Text(
                      'phone',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(),
                    15.verticalSpace,
                    SizedBox(
                      height: 115.h,
                      child: IntlPhoneField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(9),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        disableLengthCheck: true,
                        enabled: false,
                        showDropdownIcon: false,
                        showCountryFlag: false,
                        readOnly: true,
                        onChanged: (phone) {
                          // controller.verifyPhone();
                        },
                        controller: controller.phoneController,
                        key: super.key,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          errorBorder:
                              const OutlineInputBorder(borderSide: BorderSide.none),
                          hintStyle: TextStyle(
                            fontSize: 21.sp,
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: const BorderSide(color: Colors.transparent),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: const BorderSide(color: borderGreyColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: const BorderSide(color: primaryColor),
                          ),
                        ),
                        initialCountryCode: 'MA',
                        invalidNumberMessage: '',
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
