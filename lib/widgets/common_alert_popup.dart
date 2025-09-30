import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonAlertPopup extends StatelessWidget {
  final String? title;
  final Widget yesChild;
  final Widget noChild;
  final VoidCallback onYes;
  final VoidCallback onNo;
  final VoidCallback onClose;

  const CommonAlertPopup({
    super.key,
    this.title,
    required this.yesChild,
    required this.noChild,
    required this.onYes,
    required this.onNo,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      backgroundColor: const Color(0xFF1E2A3A), // Dark background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close button top-right
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: onClose,
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            if (title != null && title!.isNotEmpty) ...[
              Text(
                title!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
            ],
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    onPressed: onYes,
                    child: yesChild,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    onPressed: onNo,
                    child: noChild,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
