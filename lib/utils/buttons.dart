import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washly/utils/constants.dart';

class PrimaryButton extends StatelessWidget {
  String text;
  VoidCallback onpress;
  Color? color;
  Icon? icon;
  Size? size;
  bool transparent;
  Color textColor;
  PrimaryButton(
      {required this.text,
      required this.onpress,
      this.color = Colors.white,
      this.transparent = false,
      this.icon,
      this.size,
      this.textColor = darkColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: transparent ? Colors.blueGrey : color,
        minimumSize: size ?? Size(250.w, 67.h),
        maximumSize: size ?? Size(double.infinity.w, 67.h),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(34.r),
            side: const BorderSide(color: Colors.transparent)),
      ),
      onPressed: () {
        onpress();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null)
            icon!
          else
            const SizedBox(
              height: 0,
              width: 0,
            ),
          if (icon != null) 20.horizontalSpace,
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 19.sp,
                color: transparent ? Colors.white : textColor,
                fontWeight: FontWeight.bold),
          ).tr(),
        ],
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  String? text;
  VoidCallback? onpress;
  bool? allowed = true;
  bool? loading = false;
  double width;
  Color? fontColor;
  List<Color>? colors;
  GradientButton(
      {this.allowed = true,
      this.colors = const [Color(0xff009bfd), Color(0xff6ce7c3)],
      this.fontColor = Colors.white,
      this.text,
      this.width = 430,
      this.loading = false,
      this.onpress,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 67.h,
        width: width.w,
        decoration: BoxDecoration(
          boxShadow: allowed == true
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.16),
                    offset: const Offset(0, 3),
                    blurRadius: 6,
                  ),
                ]
              : null,
          gradient: LinearGradient(colors: [
            allowed == true ? colors![0] : colors![0].withOpacity(0.4),
            allowed == true ? colors![1] : colors![1].withOpacity(0.4),
            //add more colors
          ]),
          borderRadius: BorderRadius.circular(34.r),
        ),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              disabledForegroundColor: Colors.transparent.withOpacity(0.38),
              disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
              shadowColor: Colors.transparent,
              //make color or elevated button transparent
            ),
            onPressed: () {
              !loading!
                  ? allowed!
                      ? onpress!()
                      : null
                  : null;
            },
            child: loading!
                ? Container(
                    width: 30.w,
                    height: 30.h,
                    padding: const EdgeInsets.all(2.0),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : Text(text!,
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: fontColor,
                            fontWeight: FontWeight.bold))
                    .tr()));
  }
}
