import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/core/constants/app_constants.dart';
import 'package:Cricbites/core/constants/app_images.dart';
import 'package:Cricbites/core/constants/app_strings.dart';
import 'package:Cricbites/core/routes/app_routes.dart';
import 'package:Cricbites/features/email_verification/presentation/controllers/email_verification_controller.dart';
import 'package:Cricbites/features/otp_verification/presentation/modal/data_send.dart';
import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:Cricbites/widgets/custom_button_widget.dart';
import 'package:Cricbites/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class EmailVerificationScreen extends StatelessWidget {
  EmailVerificationScreen({super.key});

  final EmailVerificationController controller =
  Get.put(EmailVerificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CommonAppBar(
        titleText: "",
        showBackButton: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.webView,arguments: "${AppConstants.baseWebviewUrl}about-us/?app=1",);
            },
            icon: Icon(
              Icons.help_outline,
              color: AppColors.white,
              size: 24.sp,
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppColors.black,
        child: Column(
          children: [
            headingPart(),
            Expanded(
              child: bodyPart(context),
            ),
          ],
        ),
      ),
    );
  }

  headingPart() {
    return SizedBox(
      height: 100.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.verifyEmail,
            style: TextStyle(
              fontSize: 26.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            AppStrings.letsGetYouStarted,
            style: TextStyle(fontSize: 16.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }

  bodyPart(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50.r),
        ),
        border: const Border(
          top: BorderSide(
            color: AppColors.white,
            width: 1.8,
          ),
        ),
        gradient: const LinearGradient(
          colors: [
            AppColors.bodyTop,
            AppColors.bodyBottom,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.all(15.w),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          CustomTextField(
            icon: Icons.email,
            controller: controller.emailController,
            hintText: AppStrings.email,
            keyboardType: TextInputType.emailAddress,
            maxLength: 30,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z0-9@._-]'),
              ),
            ],
          ),
          SizedBox(height: 35.h),
          Obx(() => CustomButton(
            text:  AppStrings.sendOtp,
            isLoading: controller.isLoading.value,
            onPressed: controller.isLoading.value
                ? () {}
                : () {
              controller.sendEmailOtp();
            },
          )),
        ],
      ),
    );
  }
}
