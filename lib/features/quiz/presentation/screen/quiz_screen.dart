import 'package:Cricbites/features/quiz/presentation/controller/quiz_controller.dart';
import 'package:Cricbites/features/quiz/presentation/data/quiz_list_modal.dart';
import 'package:Cricbites/widgets/common_app_toast.dart';
import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:intl/intl.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizController controller = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CommonAppBar(
        titleText: "Quiz",
        showBackButton: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(color: AppColors.white));
        }

        if (controller.questions.isEmpty) {
          return const Center(
            child: Text(
              "No quiz available",
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemCount: controller.questions.length,
          itemBuilder: (context, index) {
            final question = controller.questions[index];
            return _questionCard(question);
          },
        );
      }),
    );
  }

  Widget _questionCard(Quiz question) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.white.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Image
          /*ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              question.gift ?? "",
              width: double.infinity,
              height: screenHeight / 4,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Container(
                height: screenHeight / 3,
                color: Colors.grey,
                child: Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 100.h,
                  ),
                ),
              ),
            ),
          ),*/

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// --- Title
                Text(
                  question.title ?? "",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                /// --- Description
                Text(
                  question.description ?? "",
                  style: TextStyle(
                    color: AppColors.white.withOpacity(0.7),
                    fontSize: 13.sp,
                  ),
                ),

                const SizedBox(height: 6),

                /// --- Participants
                // Text(
                //   "Total Participation: ${question.totalParticipation ?? 0}",
                //   style: TextStyle(
                //     color: AppColors.buttonTop,
                //     fontSize: 12.sp,
                //   ),
                // ),
                Text(
                  formatExpiryDate(question.expiryDate),
                  style: TextStyle(
                    color: AppColors.red,
                    fontSize: 12.sp,
                  ),
                ),

                SizedBox(height: 10.h),

                /// --- Options
                Column(
                  children: question.options!.map((answer) {
                    final key = "${question.id}_${answer.id}";

                    return Obx(() {
                      final isLoading =
                          controller.buttonLoadingMap[key] ?? false;

                      return GestureDetector(
                        onTap: isLoading
                            ? null
                            : question.expire!
                                ? () {
                                    AppToast.showError("Quiz expired");
                                  }
                                : () => controller.submitAnswer(
                                      questionId: question.id!.toString(),
                                      optionId: answer.id!.toString(),
                                    ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 12.h,
                          ),
                          decoration: question.voteOption != null &&
                                  (question.voteOption == answer.id!)
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.buttonTop,
                                      AppColors.buttonBottom,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  border: Border.all(
                                    color: AppColors.white.withOpacity(0.3),
                                  ),
                                )
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: AppColors.white.withOpacity(0.1),
                                  border: Border.all(
                                    color: AppColors.white.withOpacity(0.3),
                                  ),
                                ),
                          alignment: Alignment.center,
                          child: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.white,
                                  ),
                                )
                              : Text(
                                  answer.text ?? "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: question.voteOption != null &&
                                            (question.voteOption == answer.id!)
                                        ? AppColors.white
                                        : AppColors.white,
                                  ),
                                ),
                        ),
                      );
                    });
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatExpiryDate(DateTime? date) {
    if (date == null) return "";
    try {
      final now = DateTime.now();
      final formatter = DateFormat("d MMM yyyy, hh:mm a");
      if (date.isBefore(now)) {
        return "Expired on: ${formatter.format(date)}";
      } else {
        return "Expires on: ${formatter.format(date)}";
      }
    } catch (e) {
      return "";
    }
  }
}
