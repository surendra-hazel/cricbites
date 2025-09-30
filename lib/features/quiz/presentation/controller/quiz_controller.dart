import 'package:Cricbites/core/constants/app_prefs.dart';
import 'package:Cricbites/data/api_service/api_service.dart';
import 'package:Cricbites/features/quiz/presentation/data/quiz_list_modal.dart';
import 'package:Cricbites/widgets/common_app_toast.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  var isLoading = true.obs;
  var isButtonLoading = false.obs;
  final ApiService _apiService = ApiService();

  RxList<Quiz> questions = <Quiz>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuizQuestions();
  }

  void fetchQuizQuestions() async {
    try {
      isLoading.value = true;
      final userId = await AppPrefs.getUserId();
      if (userId == null) return;
      final result = await _apiService.quizListMethod(userId: userId);
      if (result.status!) {
        questions.assignAll(result.quizzes!);
      } else {
        questions.value = [];
      }
    } catch (e) {
      AppToast.showError("Something went wrong, Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  var buttonLoadingMap = <String, bool>{}.obs;

  Future<void> submitAnswer({String? optionId, String? questionId}) async {
    final key = "${questionId}_$optionId";
    buttonLoadingMap[key] = true;

    try {
      final userId = await AppPrefs.getUserId();
      if (userId == null) return;

      final result = await _apiService.quizResponseSubmitMethod(
        userId: userId,
        optionId: optionId,
        questionId: questionId,
      );

      if (result.status!) {
        fetchQuizQuestions();
        AppToast.showSuccess(result.message!);
      } else {
        AppToast.showError(result.message!);
      }
    } catch (e) {
      AppToast.showError("Something went wrong, Please try again.");
    } finally {
      buttonLoadingMap[key] = false;
    }
  }

}
