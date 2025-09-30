import 'package:Cricbites/features/poll/presentation/data/poll_list_modal.dart';
import 'package:Cricbites/widgets/common_app_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:intl/intl.dart';
import '../controller/poll_controller.dart';

class PollScreen extends StatefulWidget {
  const PollScreen({super.key});

  @override
  State<PollScreen> createState() => _PollScreenState();
}

class _PollScreenState extends State<PollScreen> {
  final PollController controller = Get.put(PollController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CommonAppBar(
        titleText: "Polls",
        showBackButton: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(color: AppColors.white));
        }

        if (controller.polls.isEmpty) {
          return const Center(
            child: Text(
              "No polls available",
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemCount: controller.polls.length,
          itemBuilder: (context, index) {
            final poll = controller.polls[index];
            return _pollCard(poll);
          },
        );
      }),
    );
  }

  Widget _pollCard(Poll poll) {
    bool hasVoted = poll.voteOption != null;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.white.withOpacity(0.4)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            poll.topic ?? "",
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          /// Description
          if (poll.description != null)
            Text(
              poll.description ?? "",
              style: TextStyle(
                color: AppColors.white.withOpacity(0.7),
                fontSize: 13.sp,
              ),
            ),

          const SizedBox(height: 12),

          /// Options
          Column(
            children: poll.options!.map((option) {
              double percent = (poll.totalVotes != null && double.parse(poll.totalVotes!.toString()) > 0)
                  ? (option.voteCount! / double.parse(poll.totalVotes!.toString()))
                  : 0.0;

              bool isSelected = poll.voteOption == option.id;

              return GestureDetector(
                onTap: hasVoted
                    ? null
                    : poll.expire!?(){
                  AppToast.showError("Poll has expired");
                }:() => controller.submitVote(
                  poll.id!.toString(),
                  option.id!.toString(),
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: Stack(
                    children: [
                      if (hasVoted)
                        FractionallySizedBox(
                          widthFactor: percent,
                          child: Container(
                            height: 40.h,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.buttonTop,
                                  AppColors.buttonBottom,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),

                      /// Option content
                      Container(
                        height: 40.h,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                              color: AppColors.white.withOpacity(0.3)),
                          color: AppColors.white.withOpacity(0.1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Option text + tick
                            Row(
                              children: [
                                if (isSelected)
                                  const Icon(Icons.check,
                                      color: Colors.white, size: 18),
                                if (isSelected) const SizedBox(width: 6),
                                Text(
                                  option.optionText!,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),

                            /// Percentage (visible after vote)
                            if (hasVoted)
                              Text(
                                "${option.votePercentage!.toStringAsFixed(0)}%",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 8),

          /// Total Votes (visible only after vote)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Votes: ${poll.totalVotes ?? 0}",
                  style: TextStyle(
                    color: AppColors.buttonTop,
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  formatExpiryDate(poll.expiryDate),
                  style: TextStyle(
                    color: AppColors.red,
                    fontSize: 12.sp,
                  ),
                ),
              ],
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

  // String formatExpiryDate(DateTime? date) {
  //   if (date == null) return "";
  //   try {
  //     final formatter = DateFormat("d MMM yyyy");
  //     return "Expires on: ${formatter.format(date)}";
  //   } catch (e) {
  //     return "";
  //   }
  // }
}
