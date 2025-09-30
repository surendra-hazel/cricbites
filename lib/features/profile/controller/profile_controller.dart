import 'package:Cricbites/core/constants/app_prefs.dart';
import 'package:Cricbites/data/api_service/api_service.dart';
import 'package:Cricbites/features/profile/modal/profile_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final ApiService _apiService = ApiService();

  // Text controllers
  final nameController = TextEditingController();
  final userNameController = TextEditingController();
  final cityController = TextEditingController();
  final bioController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final genderController = TextEditingController();
  final countryController = TextEditingController();
  Rx<ActivePlan>? activePlan = ActivePlan().obs;
  RxList<ActivePlan>? subscribeTransaction = List<ActivePlan>.empty().obs;
  RxString referralCode  = "".obs;

  // Observables
  var isLoading = false.obs;
  var profileImage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;
      final userId = await AppPrefs.getUserId();
      if (userId == null) return;

      final response = await _apiService.getUserProfileMethod(userId);
      if(response.status==1){
        nameController.text = response.result?.name ?? '';
        userNameController.text = response.result?.username ?? '';
        cityController.text = response.result?.city ?? '';
        bioController.text = response.result?.bio ?? '';
        dateOfBirthController.text = response.result?.dob ?? '';
        phoneNumberController.text = response.result?.mobile ?? '';
        genderController.text = response.result?.gender ?? '';
        countryController.text = response.result?.country ?? '';
        profileImage.value = response.result?.image ?? '';
        activePlan!.value = response.result?.activePlan ?? ActivePlan();
        subscribeTransaction!.value =
            response.result?.subscribeTransaction ?? [];
        referralCode.value = response.result?.refercode ?? "";
      }
    } catch (e) {
      debugPrint("Profile fetch error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    userNameController.dispose();
    cityController.dispose();
    bioController.dispose();
    dateOfBirthController.dispose();
    phoneNumberController.dispose();
    genderController.dispose();
    countryController.dispose();
    super.onClose();
  }
}
