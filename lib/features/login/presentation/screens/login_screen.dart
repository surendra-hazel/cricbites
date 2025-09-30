import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/core/constants/app_constants.dart';
import 'package:Cricbites/core/constants/app_images.dart';
import 'package:Cricbites/core/constants/app_prefs.dart';
import 'package:Cricbites/core/constants/app_strings.dart';
import 'package:Cricbites/core/routes/app_routes.dart';
import 'package:Cricbites/features/login/presentation/controllers/login_controller.dart';
import 'package:Cricbites/features/otp_verification/presentation/modal/data_send.dart';
import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:Cricbites/widgets/custom_button_widget.dart';
import 'package:Cricbites/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CommonAppBar(
        titleText: "",
        actions: [
          GestureDetector(
            onTap: () async {
              await AppPrefs.setLoginStatus(0);
              Get.offAllNamed(AppRoutes.bottomNavigation);
            },
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
              decoration: BoxDecoration(
                color: AppColors.transparent,
                border: Border.all(color: AppColors.white.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Text("Skip",style: TextStyle(color: AppColors.white,fontWeight: FontWeight.w500,fontSize: 15.sp),),
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
            Expanded(child: bodyPart(context)),
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
            AppStrings.loginRegister,
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.r)),
        border: const Border(
          top: BorderSide(color: AppColors.white, width: 1.8),
        ),
        gradient: const LinearGradient(
          colors: [AppColors.bodyTop, AppColors.bodyBottom],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.all(15.w),
      child: Column(
        children: [
          SizedBox(height: 20.h),

          /// --- Phone Number
          CustomTextField(
            icon: Icons.phone,
            controller: controller.phoneController,
            hintText: AppStrings.mobileNumber,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
          ),
          SizedBox(height: 10.h),

          /// --- Age Verification
          Obx(
                () => GestureDetector(
              onTap: controller.toggleAgeVerification,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 24.w,
                      height: 24.h,
                      child: Checkbox(
                        value: controller.isAgeVerified.value,
                        onChanged: (_) => controller.toggleAgeVerification(),
                        activeColor: AppColors.white,
                        checkColor: AppColors.black,
                        side: const BorderSide(
                          color: AppColors.textFieldBorder,
                          width: 2,
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: controller.toggleAgeVerification,
                        child: Text(
                          AppStrings.certifyAge,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 35.h),

          /// --- Send OTP Button
          Obx(
                () => CustomButton(
              text: AppStrings.sendOtp,
                  isLoading: controller.isLoading.value,
                  onPressed: () => controller.sendOtp(),
            ),
          ),

          SizedBox(height: 35.h),

          /// --- Terms & Conditions
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.white.withOpacity(0.70),
                fontWeight: FontWeight.w400,
              ),
              children: [
                const TextSpan(
                  text: 'By continuing , I agree to Cricbites  ',
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.webView,arguments: "${AppConstants.baseWebviewUrl}terms-and-conditions/?app=1");
                    },
                    child: Text(
                      'Terms & Condition',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 35.h),

          /// --- OR Divider
          Row(
            children: [
              const Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 9.w),
                child: Text(
                  AppStrings.or,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                ),
              ),
              const Expanded(child: Divider()),
            ],
          ),

          SizedBox(height: 35.h),

          /// --- Google & Facebook Login
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: controller.loginWithGoogle,
                child: socialButton(AppImages.google, AppStrings.google),
              ),
              GestureDetector(
                onTap: controller.loginWithFacebook,
                child: socialButton(AppImages.facebook, AppStrings.facebook),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// --- Social Button Widget
  Widget socialButton(String asset, String text) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: AppColors.textFieldBorder),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      child: Row(
        children: [
          Image.asset(asset, height: 24.h, width: 24.w),
          SizedBox(width: 12.w),
          Text(
            text,
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
            ),
          ),
        ],
      ),
    );
  }
}


/*
import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/core/constants/app_images.dart';
import 'package:Cricbites/core/constants/app_strings.dart';
import 'package:Cricbites/core/routes/app_routes.dart';
import 'package:Cricbites/features/otp_verification/presentation/modal/data_send.dart';
import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:Cricbites/widgets/custom_button_widget.dart';
import 'package:Cricbites/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController? phoneController = TextEditingController();
  bool? checkValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CommonAppBar(
        titleText: "",
        actions: [
          IconButton(
            onPressed: () {},
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
        // padding: EdgeInsets.all(12.h),
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
            AppStrings.loginRegister,
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
          SizedBox(
            height: 20.h,
          ),
          CustomTextField(
            icon: Icons.phone,
            controller: phoneController!,
            hintText: AppStrings.mobileNumber,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: Checkbox(
                      value: checkValue,
                      onChanged: (bool? value) {
                        setState(() {
                          checkValue = !checkValue!;
                        });
                      },
                      activeColor: AppColors.white,
                      checkColor: AppColors.black,
                      side: const BorderSide(
                        color: AppColors.textFieldBorder,
                        width: 2,
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        AppStrings.certifyAge,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 35.h,
          ),
          CustomButton(
            text: AppStrings.sendOtp,
            onPressed: () {
              UserData userData = UserData(email: false, value: phoneController!.text);
              Get.toNamed(AppRoutes.otpVerification,extra: userData);
            },
          ),
          SizedBox(
            height: 35.h,
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.white.withOpacity(0.70),
                fontWeight: FontWeight.w400,
              ),
              children: [
                const TextSpan(
                  text: 'By continuing , I agree to Cricbites  ',
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Terms & Condition',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 35.h,
          ),
          Row(
            children: [
              const Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 9.w),
                child: Text(
                  AppStrings.or,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                ),
              ),
              const Expanded(child: Divider()),
            ],
          ),
          SizedBox(
            height: 35.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(
                    color: AppColors.textFieldBorder,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical:10.h,horizontal: 15.w),
                child: Row(
                  children: [
                    Image(
                      image: const AssetImage(AppImages.google),
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Text(
                      AppStrings.google,
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(
                    color: AppColors.textFieldBorder,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical:10.h,horizontal: 15.w),
                child: Row(
                  children: [
                    Image(
                      image: const AssetImage(AppImages.facebook),
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Text(
                      AppStrings.facebook,
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
*/
