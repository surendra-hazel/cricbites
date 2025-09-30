import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/core/constants/app_images.dart';
import 'package:Cricbites/widgets/common_app_toast.dart';
import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:Cricbites/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

class InviteFriendScreen extends StatelessWidget {
  final String referralCode;

  const InviteFriendScreen({super.key, required this.referralCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CommonAppBar(
        titleText: "Invite Friend",
        showBackButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(height: 40.h),

            /// 🔹 Illustration / Icon
            Lottie.asset(AppImages.shareJson),

            // SizedBox(height: 20.h),

            Text(
              "Invite Your Friends",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Share your referral code and earn rewards\nwhen your friends join!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.white.withOpacity(0.7),
              ),
            ),

            SizedBox(height: 30.h),

            /// 🔹 Referral Code Box
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    referralCode,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonTop,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: referralCode));
                      AppToast.showSuccess("Referral code copied!");
                    },
                    icon: const Icon(Icons.copy, color: Colors.white),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),

            /// 🔹 Share Button
            CustomButton(text: "Share with Friends", onPressed: () {
      final shareText =
      "Hey! Join Cricbites and use my referral code 👉 $referralCode to sign up. Download now!";
      Share.share(shareText);
      },),
          ],
        ),
      ),
    );
  }
}
