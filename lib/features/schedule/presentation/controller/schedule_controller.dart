import 'package:Cricbites/core/constants/app_prefs.dart';
import 'package:Cricbites/data/api_service/api_service.dart';
import 'package:Cricbites/widgets/common_app_toast.dart';
import 'package:get/get.dart';
import 'package:Cricbites/features/schedule/data/schedule_list_modal.dart';

class ScheduleController extends GetxController {
  var isLoading = false.obs;
  RxList<Heading> headings = <Heading>[].obs;
  RxList<ScheduleList> matches = <ScheduleList>[].obs;
  final ApiService _apiService = ApiService();

  Future<void> fetchSchedule({
    String? matchStatus,
    String? competitionId,
  }) async {
    try {
      isLoading.value = true;
      final userId = await AppPrefs.getUserId();
      if (userId == null) return;
      final result = await _apiService.scheduleListMethod(
        userId: userId,
        matchStatus: matchStatus,
        competitionId: competitionId??"0",
      );

      if(result.status==1){
        headings.value= result.heading ?? [];
        matches.value= result.data??[];
        if(headings.isNotEmpty){
          headings.insert(
              0,
              Heading(
                compId: 0,
                compName: "All Matches",
              ));
        }
      }else{
        headings.value = [];
        matches.value = [];
      }
    } catch (e) {
      AppToast.showError("Something went wrong, Please try again.");
    } finally {
      isLoading.value = false;
    }
  }
}
