import 'package:Cricbites/data/api_service/api_service.dart';
import 'package:Cricbites/widgets/common_app_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController {
  // Text Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();

  // Dropdown (category)
  RxString selectedCategory = "".obs;

  // Loader
  RxBool isLoading = false.obs;
  final ApiService _apiService = ApiService();

  /// ✅ Validation method
  bool validateForm() {
    if (nameController.text.trim().isEmpty) {
      AppToast.showError("Please enter your full name");
      return false;
    }
    if (emailController.text.trim().isEmpty ||
        !GetUtils.isEmail(emailController.text.trim())) {
      AppToast.showError("Please enter a valid email");
      return false;
    }
    if (mobileController.text.trim().isEmpty ||
        mobileController.text.trim().length < 10) {
      AppToast.showError("Please enter a valid mobile number");
      return false;
    }
    if (selectedCategory.value.isEmpty) {
      AppToast.showError("Please select a category");
      return false;
    }
    if (subjectController.text.trim().isEmpty) {
      AppToast.showError("Please enter subject");
      return false;
    }
    if (descriptionController.text.trim().isEmpty) {
      AppToast.showError("Please enter description");
      return false;
    }
    return true;
  }

  /// ✅ Submit Feedback API Call
  Future<void> submitFeedback() async {
    if (!validateForm()) return;

    isLoading.value = true;
    try {
      final response = await _apiService.feedbackMethod(
        fullName: nameController.text.trim(),
        email: emailController.text.trim(),
        mobile: mobileController.text.trim(),
        category: selectedCategory.value,
        subject: subjectController.text.trim(),
        description: descriptionController.text.trim(),
      );

      if(response.status==1){
        Get.back();
        AppToast.showSuccess("Your feedback submitted successfully");
      }
      nameController.clear();
      emailController.clear();
      mobileController.clear();
      subjectController.clear();
      descriptionController.clear();
      selectedCategory.value = "";

    } catch (e) {
      AppToast.showError("Failed to submit feedback: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    subjectController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
