import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/core/constants/app_constants.dart';
import 'package:Cricbites/core/constants/app_strings.dart';
import 'package:Cricbites/core/routes/app_routes.dart';
import 'package:Cricbites/features/otp_verification/presentation/controllers/otp_verification_controller.dart';
import 'package:Cricbites/features/otp_verification/presentation/modal/data_send.dart';
import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:Cricbites/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends StatelessWidget {
  final UserData userData;

  OtpVerificationScreen({super.key, required this.userData});

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
      fontSize: 20.sp,
      color: AppColors.white,
    ),
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.textFieldBorder),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OtpVerificationController(userData));

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CommonAppBar(
        titleText: "",
        onBack: () => Get.back(),
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
              child: bodyPart(context, controller),
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
            AppStrings.otpVerification,
            style: TextStyle(
              fontSize: 26.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "${AppStrings.otpSentOn}${userData.value}",
            style: TextStyle(fontSize: 14.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }

  bodyPart(BuildContext context, OtpVerificationController controller) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text(
            AppStrings.enterOTP,
            style: TextStyle(
              fontSize: 15.sp,
              color: AppColors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 10.h),

          // OTP Input
        Center(
          child: Pinput(
            controller: controller.otpController,
            length: 6,
            enableInteractiveSelection: false,
            separatorBuilder: (index) => const SizedBox(width: 8),
            hapticFeedbackType: HapticFeedbackType.lightImpact,
            // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi, // ✅ Autofill enable
            // listenForMultipleSmsOnAndroid: true, // ✅ Multiple SMS listen karega
            closeKeyboardWhenCompleted: true,    // Optional

            cursor: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 9),
                  width: 22,
                  height: 1,
                  color: AppColors.textFieldBorder,
                ),
              ],
            ),
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                border: Border.all(color: AppColors.textFieldBorder),
              ),
            ),
            submittedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                border: Border.all(color: AppColors.textFieldBorder),
              ),
            ),
            errorPinTheme: defaultPinTheme.copyBorderWith(
              border: Border.all(color: Colors.redAccent),
            ),

            onCompleted: (pin) {
              print("OTP Entered: $pin");
              // controller.verifyOtp(pin);
            },
          ),
        ),

        SizedBox(height: 20.h),
          Center(
            child: Column(
              children: [
                Text(
                  AppStrings.didNotReceiveCode,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Center(
                  child: Obx(() {
                    if (controller.remainingSeconds.value > 0) {
                      return Text(
                        "00:${controller.remainingSeconds.value.toString().padLeft(2, '0')} Sec",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.red,
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: controller.resendOtp,
                        child: Text(
                          AppStrings.resendOTP,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: AppColors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      );
                    }
                  }),
                ),
              ],
            ),
          ),

          SizedBox(height: 35.h),

          // Verify OTP Button with loader
          Obx(() => CustomButton(
            text: AppStrings.verifyOTP,
            isLoading: controller.isLoading.value,
            onPressed: (){
              controller.verifyOtp(userData.isLogin);
            },
          )),
        ],
      ),
    );
  }
}
