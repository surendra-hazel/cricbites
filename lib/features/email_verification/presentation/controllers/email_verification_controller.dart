import 'dart:convert';
import 'package:Cricbites/core/routes/app_routes.dart';
import 'package:Cricbites/data/api_service/api_service.dart';
import 'package:Cricbites/features/otp_verification/presentation/modal/data_send.dart';
import 'package:Cricbites/widgets/common_app_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationController extends GetxController {
  final ApiService _apiService = ApiService();
  final TextEditingController emailController = TextEditingController();

  final isLoading = false.obs;

  Future<void> sendEmailOtp() async {
    if (!_validateForm()) return;

    isLoading.value = true;
    try {
      final response = await _apiService.emailVerifyMethod(emailController.text);
      final data = jsonDecode(jsonEncode(response));
      if (data["status"] == 1) {
        final userData = UserData(
          email: true,
          value: emailController.text,
          isLogin: true,
        );
        Get.toNamed(AppRoutes.otpVerification, arguments: userData);
        AppToast.showSuccess(data["message"] ?? "OTP sent successfully");
      } else {
        AppToast.showError(data["message"] ?? "Failed to send OTP");
      }
    } catch (e) {
      AppToast.showError(
        "Something went wrong, Please try again later!",
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Form Validation
  bool _validateForm() {
    if (emailController.text.isEmpty) {
      AppToast.showError('Please enter your email address');
      return false;
    }

    // Email regex check
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!emailRegex.hasMatch(emailController.text)) {
      AppToast.showError('Please enter a valid email address');
      return false;
    }

    return true;
  }
}
