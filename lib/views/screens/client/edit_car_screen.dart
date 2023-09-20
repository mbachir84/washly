// import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:washly/controllers/client/edit_car_controller.dart';
import '../../../utils/buttons.dart';

class EditCarScreen extends StatelessWidget {
  const EditCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: GetBuilder<EditCarController>(
                init: EditCarController(),
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
                            'editcar',
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
                      27.verticalSpace,
                      InkWell(
                        onTap: () {
                          controller.selectImage();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(9.r),
                          child: Stack(
                            children: [
                              controller.file == null
                                  ? CachedNetworkImage(
                                      imageUrl: controller.car.image!,
                                      height: 200.h,
                                      width: double.infinity.w,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => const Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )
                                  : Image.file(
                                      controller.image!,
                                      height: 200.h,
                                      width: double.infinity.w,
                                      fit: BoxFit.cover,
                                    ),
                              controller.file != null
                                  ? Align(
                                      alignment: Alignment.topRight,
                                      child: InkWell(
                                        onTap: () {
                                          controller.removeImage();
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 17.w, right: 17.h),
                                          child: SvgPicture.asset(
                                            'assets/images/remove.svg',
                                            height: 27.w,
                                            width: 27.w,
                                          ),
                                        ),
                                      ))
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                      28.verticalSpace,
                      Text(
                        'make',
                        style: TextStyle(
                            color: const Color(0xff698695),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500),
                      ).tr(),
                      12.verticalSpace,
                      GetBuilder<EditCarController>(
                          init: EditCarController(),
                          builder: (controller) {
                            return SizedBox(
                                width: double.infinity,
                                height: 54.h,
                                child: CustomDropdown.search(
                                  selectedStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500),
                                  borderSide: BorderSide(
                                      color: const Color(0xff698695), width: 1.w),
                                  borderRadius: BorderRadius.circular(5.r),
                                  onChanged: (value) {
                                    controller.modelController.clear();
                                    controller.updateCars();
                                    controller.verify();
                                  },
                                  hintText: tr('selectmake'),
                                  items: controller.carsMake,
                                  controller: controller.makeController,
                                ));
                          }),
                      27.verticalSpace,
                      Text(
                        'model',
                        style: TextStyle(
                            color: const Color(0xff698695),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500),
                      ).tr(),
                      12.verticalSpace,
                      GetBuilder<EditCarController>(
                          init: EditCarController(),
                          builder: (controller) {
                            return SizedBox(
                                width: double.infinity,
                                height: 54.h,
                                child: CustomDropdown.search(
                                  borderSide: BorderSide(
                                      color: const Color(0xff698695), width: 1.w),
                                  borderRadius: BorderRadius.circular(5.r),
                                  selectedStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500),
                                  onChanged: (value) {
                                    controller.verify();
                                  },
                                  hintText: tr('selectmodel'),
                                  items: controller.carsModel,
                                  controller: controller.modelController,
                                ));
                          }),
                      27.verticalSpace,
                      Text(
                        'licenceplate',
                        style: TextStyle(
                            color: const Color(0xff698695),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500),
                      ).tr(),
                      12.verticalSpace,
                      GetBuilder<EditCarController>(
                          init: EditCarController(),
                          builder: (controller) {
                            return SizedBox(
                              width: double.infinity,
                              height: 54.h,
                              child: TextField(
                                controller: controller.licencePlateController,
                                onChanged: (value) {
                                  controller.suffixIconEnabled =
                                      value.isNotEmpty;
                                  controller.verify();
                                },
                                decoration: InputDecoration(
                                    suffixIcon: controller.suffixIconEnabled
                                        ? InkWell(
                                            onTap: () {
                                              controller.suffixIconEnabled =
                                                  false;

                                              controller.licencePlateController
                                                  .clear();
                                              controller.verify();
                                            },
                                            child: Icon(
                                              CupertinoIcons.xmark_circle_fill,
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              size: 24.w,
                                            ),
                                          )
                                        : null,
                                    hintStyle: TextStyle(
                                        color: const Color(0xff698695),
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: BorderSide(
                                            color: const Color(0xff698695),
                                            width: 1.w)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: BorderSide(
                                            color: const Color(0xff698695),
                                            width: 1.w))),
                              ),
                            );
                          }),
                      69.verticalSpace,
                      GetBuilder<EditCarController>(
                          init: EditCarController(),
                          builder: (controller) {
                            return SizedBox(
                              width: 382.w,
                              height: 67.h,
                              child: GradientButton(
                                loading: controller.isLoading.value,
                                allowed: controller.isVerified,
                                text: 'savechanges',
                                onpress: () {
                                  controller.submit();
                                },
                              ),
                            );
                          }),
                      37.verticalSpace,
                      GetBuilder<EditCarController>(
                          init: EditCarController(),
                          builder: (controller) {
                            return Center(
                              child: TextButton(
                                onPressed: () {
                                  controller.deleteCar();
                                },
                                child: Text(
                                  'deletecar',
                                  style: TextStyle(
                                    color: const Color(0xff030303),
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ).tr(),
                              ),
                            );
                          }),
                    ],
                  );
                }),
          ),
        ));
  }
}
