import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatelessWidget {
  TextEditingController? controller = TextEditingController();
  TextFieldWidget({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54.h,
      child: TextField(
        controller: controller,
        onChanged: (value) {},
        decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: () {},
              child: Icon(
                CupertinoIcons.xmark_circle_fill,
                color: Colors.grey.withOpacity(0.5),
                size: 24.w,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            hintStyle: TextStyle(
                color: const Color(0xff698695),
                fontSize: 18.sp,
                fontWeight: FontWeight.w500),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: BorderSide.none),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
