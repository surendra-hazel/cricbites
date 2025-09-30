import 'dart:convert';

import 'package:Cricbites/core/routes/app_routes.dart';
import 'package:Cricbites/data/api_service/api_service.dart';
import 'package:Cricbites/features/login/modal/login_modal.dart';
import 'package:Cricbites/features/otp_verification/presentation/modal/data_send.dart';
import 'package:Cricbites/widgets/common_app_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  final RxBool isAgeVerified = false.obs;
  final RxBool isLoading = false.obs;
  final ApiService _apiService = ApiService();

  LoginModal? loginData;

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }

  void toggleAgeVerification() {
    isAgeVerified.value = !isAgeVerified.value;
  }

  Future<void> sendOtp() async {
    if (!_validateForm()) return;

    isLoading.value = true;
    try {
      final response = await _apiService.loginMethod(phoneController.text);
      loginData = loginModalFromJson(jsonEncode(response));
      if (loginData?.status == 1) {
        if (loginData!.isLoginSuccess) {
          print("User logged in successfully ✅");
          final userData = UserData(
            email: false,
            value: phoneController.text,
            isLogin: true,
          );
          Get.toNamed(AppRoutes.otpVerification, arguments: userData);
        } else  {
          final userData = UserData(
            email: false,
            value: phoneController.text,
            isLogin: false,
          );
          Get.toNamed(AppRoutes.otpVerification, arguments: userData);
        }

      } else {
        AppToast.showError(loginData?.message ?? "Failed to send OTP");
      }
    } catch (e) {
      AppToast.showError(
        "Something went wrong, Please try again after some time!",
      );
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateForm() {
    if (phoneController.text.isEmpty) {
      AppToast.showError('Please enter your mobile number');
      return false;
    }

    if (phoneController.text.length != 10) {
      AppToast.showError('Please enter a valid 10-digit mobile number');
      return false;
    }

    if (!isAgeVerified.value) {
      AppToast.showError('Please verify that you are above 18 years');
      return false;
    }

    return true;
  }

  void loginWithGoogle() {
    AppToast.showInfo('Google login functionality will be implemented');
  }

  void loginWithFacebook() {
    AppToast.showInfo('Facebook login functionality will be implemented');
  }
}
