import 'dart:async';
import 'dart:convert';
import 'package:Cricbites/core/constants/app_prefs.dart';
import 'package:Cricbites/core/routes/app_routes.dart';
import 'package:Cricbites/data/api_service/api_service.dart';
import 'package:Cricbites/features/login/modal/login_modal.dart';
import 'package:Cricbites/features/login/presentation/controllers/login_controller.dart';
import 'package:Cricbites/features/otp_verification/presentation/modal/data_send.dart';
import 'package:Cricbites/features/otp_verification/presentation/modal/otp_verification_modal.dart';
import 'package:Cricbites/widgets/common_app_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpVerificationController extends GetxController {
  final ApiService _apiService = ApiService();
  final TextEditingController otpController = TextEditingController();
  final RxBool isLoading = false.obs;
  final UserData userData;
  final RxInt remainingSeconds = 0.obs;
  Timer? _timer;

  OtpVerificationController(this.userData);

  final LoginController loginController = Get.find<LoginController>();
  @override
  void onInit() {
    super.onInit();
    // startTimer();
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }

  void startTimer() {
    remainingSeconds.value = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void resendOtp() {
    remainingSeconds.value = 30;
    loginController.sendOtp();
    startTimer();
  }

  Future<void> verifyOtp(bool isLogin) async {
    if (!_validateForm()) return;

    isLoading.value = true;
    try {
      final response = await _apiService.loginOtpVerifyMethod(
        userData.value, // mobile/email
        otpController.text,
      );

      final result = otpVerificationModalFromJson(jsonEncode(response));
      if (result.status == 1) {
        await AppPrefs.saveUserData(
          userId: result.user!.userId.toString() ,
          userName: result.user!.username ?? "",
          email: result.user!.email ?? "",
          token: result.token ?? "",
          mobileNo: result.user?.mobile??0,
          userImage: result.user?.image??"",
        );
        if(isLogin){
          await AppPrefs.setLoginStatus(1);
          Get.offAllNamed(AppRoutes.bottomNavigation);
        }else{
          Get.offNamed(AppRoutes.setProfile);
        }
      } else {
        AppToast.showError(result.message ?? "Invalid OTP");
      }
    } catch (e) {
      AppToast.showError("Something went wrong, Please try again later!");
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateForm() {
    if (otpController.text.isEmpty) {
      AppToast.showError("Please enter the OTP");
      return false;
    }

    if (otpController.text.length != 6) {
      AppToast.showError("Please enter a valid 6-digit OTP");
      return false;
    }

    return true;
  }
}
