import 'package:Cricbites/core/constants/app_prefs.dart';
import 'package:Cricbites/data/api_service/api_service.dart';
import 'package:Cricbites/features/poll/presentation/data/poll_list_modal.dart';
import 'package:Cricbites/widgets/common_app_toast.dart';
import 'package:get/get.dart';

class PollController extends GetxController {
  var isLoading = false.obs;
  var polls = <Poll>[].obs;
  var isVoting = false.obs;
  var selectedOption = <int, int>{}.obs;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchPolls();
  }

  Future<void> fetchPolls() async {
    try {
      isLoading.value = true;
      final userId = await AppPrefs.getUserId();
      if (userId == null) return;
      final result = await _apiService.pollListMethod(userId: userId);
      if (result.success!) {
        polls.assignAll(result.polls!);
      } else {
        polls.value = [];
      }
    } catch (e) {
      AppToast.showError("Something went wrong, Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitVote(String pollId, String optionId) async {
    try {
      isVoting.value = true;
      final userId = await AppPrefs.getUserId();
      if (userId == null) return;

      final result = await _apiService.pollVoteMethod(
        userId: userId,
        questionId: pollId,
        optionId: optionId,
      );

      if (result.success == true) {
        AppToast.showSuccess("Vote submitted successfully!");
        selectedOption[int.parse(pollId)] = int.parse(optionId);
        await fetchPolls();
      } else {
        AppToast.showError(result.message ?? "Vote failed");
      }
    } catch (e) {
      AppToast.showError("Something went wrong, Please try again.");
    } finally {
      isVoting.value = false;
    }
  }
}
