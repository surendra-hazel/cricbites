import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final IconData? icon;
  final Key? buttonKey;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.buttonKey,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        key: buttonKey,
        duration: const Duration(milliseconds: 300),
        height: 48.h,
        width: isLoading ? 48.h : MediaQuery.of(context).size.width, // 🔥 shrink
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          gradient: const LinearGradient(
            colors: [
              AppColors.buttonTop,
              AppColors.buttonBottom,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.r),
            ),
            padding: EdgeInsets.zero,
          ),
          onPressed: isLoading ? null : onPressed,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: isLoading
                ? SizedBox(
              key: const ValueKey("loader"),
              height: 24.h,
              width: 24.h,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor:
                AlwaysStoppedAnimation<Color>(AppColors.white),
              ),
            )
                : Row(
              key: const ValueKey("text"),
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon!, color: AppColors.black, size: 20.sp),
                  SizedBox(width: 8.w),
                ],
                Flexible(
                  child: Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
