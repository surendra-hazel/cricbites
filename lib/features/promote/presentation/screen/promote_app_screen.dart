import 'package:Cricbites/core/routes/app_routes.dart';
import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:Cricbites/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:get/get.dart';

class PromoteAppScreen extends StatelessWidget {
  const PromoteAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CommonAppBar(
        titleText: "Promote App",
        showBackButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            SizedBox(height: 40.h),
            // App icon / promotion illustration
            CircleAvatar(
              radius: 45.r,
              backgroundColor: AppColors.primaryColor.withOpacity(0.2),
              child: Icon(Icons.campaign,
                  size: 50.sp, color: AppColors.white),
            ),
            SizedBox(height: 24.h),

            // Title
            Text(
              "Do you want to collaborate with us?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12.h),

            // Subtitle
            const Text(
              "Are you a YouTuber or do you have a Telegram channel? Do you want to promote Cricbites?",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            SizedBox(height: 100.h),
            CustomButton(text: "Continue", onPressed: (){
              Get.toNamed(AppRoutes.promoteDetail);
            }),
          ],
        ),
      ),
    );
  }
}
