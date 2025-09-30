import 'package:Cricbites/core/constants/app_prefs.dart';
import 'package:Cricbites/core/routes/app_routes.dart';
import 'package:Cricbites/data/api_service/api_service.dart';
import 'package:Cricbites/features/set_profile/presentation/controllers/set_profile_controller.dart';
import 'package:Cricbites/widgets/common_app_toast.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';

class MoreController extends GetxController {
  final ApiService _apiService = ApiService();
  final InAppReview _inAppReview = InAppReview.instance;
  Future<void> rateThisApp() async {
    try {
      if (await _inAppReview.isAvailable()) {
        await _inAppReview.requestReview();
      } else {
        await _inAppReview.openStoreListing(
          appStoreId: "YOUR_IOS_APP_ID",
        );
      }
    } catch (e) {
      print("Error in rateThisApp: $e");
    }
  }

  Future<void> logoutUser() async {
    try {
      showLoaderDialog(Get.context!);

      final userId = await AppPrefs.getUserId();
      final mobileNo = await AppPrefs.getUserMobileNo();

      final response = await _apiService.logoutMethod(
        userId: userId,
        mobileNo: mobileNo,
      );

      if (response.status == 1) {
        await AppPrefs.clearUserData();
        Get.offAllNamed(AppRoutes.login);
      } else {
        AppToast.showError(response.message ?? "Logout failed");
      }
    } catch (e) {
      if (Get.isDialogOpen == true) Get.back();
      AppToast.showError("Something went wrong. Please try again!");
    } finally{
      Get.back();
    }
  }
}
