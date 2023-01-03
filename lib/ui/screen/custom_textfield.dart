import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final onChanged;
  final validator;
  final hintText;
  final controller;
  final preFixIcon;
  final bool obscureText;
  final bool readOnly;
  final textInputAction;
  final keyBoardType;
  final IconButton? suffixIcon;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;

  CustomTextField({
    this.preFixIcon,
    this.readOnly = false,
    this.onChanged,
    this.controller,
    this.hintText,
    this.validator,
    this.obscureText = false,
    this.textInputAction,
    this.keyBoardType,
    this.suffixIcon,
    this.focusNode,
    this.onFieldSubmitted,
    EdgeInsets? contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: keyBoardType,
        readOnly: readOnly,
        onChanged: onChanged,
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(fontSize: 14.sp),
        onFieldSubmitted: onFieldSubmitted,
        focusNode: focusNode,
        obscuringCharacter: "*",
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFF8F8F8),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Colors.black38,
          ),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
