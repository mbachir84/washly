import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemProfileMenu extends StatelessWidget {
  final String title;
  final String description;

  final String iconPath;
  final String data;

  final Function()? onTap;
  const ItemProfileMenu(
      {super.key,
      this.description = "",
      this.data = "",
      required this.iconPath,
      required this.title,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Container(
              height: 1,
              width: 1.sw,
              color: const Color(0xff698695).withOpacity(0.2),
            ),
            17.5.verticalSpace,
            Row(
              children: [
                SvgPicture.asset(
                  iconPath,
                  height: 42.sp,
                  width: 42.sp,
                ),
                14.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff030303),
                        )).tr(),
                    Visibility(
                        visible: description.isNotEmpty,
                        child: 5.verticalSpace),
                    Visibility(
                      visible: description.isNotEmpty,
                      child: Center(
                        child: Text(description,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff030303),
                            )).tr(),
                      ),
                    ),
                  ],
                ),
                15.horizontalSpace,
                const Spacer(),
                Visibility(
                  visible: data.isNotEmpty,
                  child: Text(data,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff030303)))
                      .tr(),
                ),
              ],
            ),
            17.5.verticalSpace,
          ],
        ),
      ),
    );
  }
}
