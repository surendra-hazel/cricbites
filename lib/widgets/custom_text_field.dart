import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextInputAction textInputAction;
  double? borderRadius;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final int maxLength;
  final int maxLine;

  CustomTextField({
    super.key,
    required this.icon,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
    this.textInputAction = TextInputAction.next,
    this.borderRadius = 50,
    this.inputFormatters,
    this.onChanged,
    this.maxLength = 200,
    this.maxLine = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.transparent,
        border: Border.all(color: readOnly?AppColors.white.withOpacity(0.6):AppColors.white.withOpacity(0.3),),
        borderRadius: BorderRadius.circular(borderRadius?.r ?? 50.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!icon.isNull) ...[
            Icon(icon,color: AppColors.white,),
            SizedBox(width: 9.w),
            Container(
              width: 0.8,
              height: 24.h,
              color: readOnly?AppColors.white.withOpacity(0.6):AppColors.textFieldBorder,
            ),
            SizedBox(width: 9.w),
          ],
          Expanded(
            child: Center(
              child: TextFormField(
                maxLength: maxLength,
                cursorColor: AppColors.white,
                readOnly: readOnly,
                enabled: !readOnly,
                onTap: onTap,
                maxLines: maxLine,
                onChanged: onChanged,
                autofillHints: null,
                enableSuggestions: false,
                autocorrect: false,
                controller: controller,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                inputFormatters: inputFormatters ?? [],
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.36,
                  color: AppColors.white,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  isDense: true,
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: AppColors.textFieldHintColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.36,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

