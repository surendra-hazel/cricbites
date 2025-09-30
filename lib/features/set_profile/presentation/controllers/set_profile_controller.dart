import 'dart:convert';
import 'dart:io';
import 'package:Cricbites/core/constants/app_prefs.dart';
import 'package:Cricbites/core/routes/app_routes.dart';
import 'package:Cricbites/data/api_service/api_service.dart';
import 'package:Cricbites/features/set_profile/presentation/modal/set_profile_modal.dart';
import 'package:Cricbites/widgets/common_app_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SetProfileController extends GetxController {
  final ApiService _apiService = ApiService();

  // Controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();

  final RxString selectedGender = "".obs;
  final RxString selectedCountry = "".obs;
  final RxString profileImage = "".obs;
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxBool isLoading = false.obs;

  String? userId;
  String? userEmail;
  String? userMobileNo;

  @override
  void onInit() {
    super.onInit();
    _loadUserDataFromPrefs();
  }

  Future<void> _loadUserDataFromPrefs() async {
    userId = await AppPrefs.getUserId();
    userEmail = await AppPrefs.getEmail();
    userMobileNo = await AppPrefs.getUserMobileNo();
  }

  @override
  void onClose() {
    nameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    cityController.dispose();
    bioController.dispose();
    dateOfBirthController.dispose();
    super.onClose();
  }

  Future<void> setProfile() async {
    if (!_validateForm()) return;

    isLoading.value = true;
    try {
      final response = await _apiService.setProfileMethod(
        userId: userId!,
        fullName: userNameController.text.trim(),
        emailId: emailController.text.trim(),
        address: "",
        city: cityController.text,
        country: selectedCountry.value,
        dob: dateOfBirthController.text,
        gender: selectedGender.value,
        mobileNo: userMobileNo,
        state: cityController.text,
        userName: userNameController.text,
      );

      final result = SetProfileModal.fromJson(jsonDecode(jsonEncode(response)));

      if (result.status == 1) {
        await AppPrefs.setLoginStatus(1);
        Get.offAllNamed(AppRoutes.bottomNavigation);
      } else {
        AppToast.showError(result.message ?? "Failed to update profile");
      }
    } catch (e) {
      AppToast.showError("Something went wrong, Please try again later!");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      uploadProfileImage();
    }
  }

  Future<void> uploadProfileImage() async {
    if (selectedImage.value == null) {
      AppToast.showError("Please select an image first");
      return;
    }

    final userId = await AppPrefs.getUserId();
    if (userId == null) {
      AppToast.showError("User not found");
      return;
    }

    showLoaderDialog(Get.context!);

    try {
      final result = await _apiService.uploadUserImage(userId, selectedImage.value!);
      if (result.status == 1) {
        profileImage.value=result.file!;
        await AppPrefs.saveUserImage(profileImage.value);
        AppToast.showSuccess(result.message ?? "Profile image updated!");
      } else {
        AppToast.showError(result.message ?? "Failed to update image");
      }
    } catch (e) {
      Get.back();
      AppToast.showError("Something went wrong while uploading image");
    } finally{
      Get.back();
    }
  }


  bool _validateForm() {
    if (profileImage.value.isEmpty) {
      AppToast.showError("Please select profile image");
      return false;
    }
    if (nameController.text.isEmpty) {
      AppToast.showError("Please enter your full name");
      return false;
    }

    if (userNameController.text.isEmpty) {
      AppToast.showError("Please enter a username");
      return false;
    }

    if (selectedGender.value.isEmpty) {
      AppToast.showError("Please select gender");
      return false;
    }

    if (selectedCountry.value.isEmpty) {
      AppToast.showError("Please select country");
      return false;
    }

    if (cityController.text.isEmpty) {
      AppToast.showError("Please enter city");
      return false;
    }
    if (dateOfBirthController.text.isEmpty) {
      AppToast.showError("Please select your date of birth");
      return false;
    }
    if (bioController.text.isEmpty) {
      AppToast.showError("Please enter bio");
      return false;
    }
    return true;
  }
}


void showLoaderDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: const Color(0xFF1E2A3A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                "Please wait...",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    },
  );
}
