import 'package:Cricbites/core/constants/app_prefs.dart';
import 'package:Cricbites/data/api_service/api_service.dart';
import 'package:Cricbites/widgets/common_app_toast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EditProfileController extends GetxController {
  final ApiService _apiService = ApiService();

  var isLoading = false.obs;

  // Text Controllers
  final nameController = TextEditingController();
  final userNameController = TextEditingController();
  final cityController = TextEditingController();
  final bioController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  var selectedGender = "".obs;
  var selectedCountry = "".obs;

  String? userId;

  Future<void> initData(Map<String, dynamic>? args) async {
    userId = await AppPrefs.getUserId();
    if (args != null) {
      nameController.text = args["name"] ?? "";
      userNameController.text = args["username"] ?? "";
      cityController.text = args["city"] ?? "";
      bioController.text = args["bio"] ?? "";
      dateOfBirthController.text = args["dob"] ?? "";
      selectedGender.value = args["gender"] ?? "";
      selectedCountry.value = args["country"] ?? "";
      userId = userId;
    }
  }

  /// Update profile API call
  Future<void> updateProfile() async {
    try {
      isLoading.value = true;

      final response = await _apiService.updateProfileMethod(
        userId: userId,
        userName: userNameController.text,
        fullName: nameController.text,
        dob: dateOfBirthController.text,
        gender: selectedGender.value,
        city: cityController.text,
        address: "",
        state: "",
        country: selectedCountry.value,
      );

      if (response.status == 1) {
        Get.back(result: true);
      } else {
        AppToast.showError(response.message ?? "Failed to update");
      }
    } catch (e) {
      AppToast.showError("Something went wrong. Please try again!");
    } finally {
      isLoading.value = false;
    }
  }
}
