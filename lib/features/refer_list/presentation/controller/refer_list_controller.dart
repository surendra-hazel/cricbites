import 'package:Cricbites/core/constants/app_prefs.dart';
import 'package:Cricbites/data/api_service/api_service.dart';
import 'package:Cricbites/features/refer_list/presentation/modal/refer_list_modal.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class ReferListController extends GetxController {
  var isLoading = false.obs;
  var referList = <ReferralList>[].obs;
  var totalUser = 0.obs;
  var totalAmount = "0.00".obs;

  final Dio _dio = Dio();

  Future<void> fetchReferList() async {
    try {
      isLoading.value = true;
      final userId = await AppPrefs.getUserId();
      if (userId == null) return;
      final response = await ApiService().getReferListMethod(userId);

      if (response.status== 1) {
        referList.assignAll(response.result!);
        totalUser.value = response.totalUser!;
        totalAmount.value = response.totalAmount!;
      } else {
        Get.snackbar("Error", "Failed to fetch refer list");
      }
    } catch (e) {
      Get.snackbar("Error", "API error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchReferList();
    super.onInit();
  }
}
