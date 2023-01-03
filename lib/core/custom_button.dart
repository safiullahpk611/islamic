import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  final text;
  final textColor;
  final buttonColor;
  Button({this.text, this.buttonColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: Colors.white, width: 0.5),
        ),
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.h),
          child: Center(
            child: Text(
              text.toString(),
              style: TextStyle(
                  fontSize: 18.sp,
                  color: textColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
