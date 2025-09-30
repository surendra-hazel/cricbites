import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/features/profile/modal/profile_modal.dart';
import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RxList<ActivePlan>? transactions = Get.arguments ?? [];

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CommonAppBar(
        titleText: "Subscription History",
        showBackButton: true,
      ),
      body: transactions!.isEmpty
          ? const Center(
        child: Text(
          "No history found",
          style: TextStyle(color: Colors.white70),
        ),
      )
          : ListView.separated(
        padding: EdgeInsets.all(15.w),
        itemCount: transactions.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final tx = transactions[index];

          return Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white24, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tx.planName ?? "",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${tx.currency ?? ""} ${tx.amount ?? ""}",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                // Duration
                Text(
                  "Duration: ${tx.durationValue} ${tx.durationType}",
                  style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                ),
                SizedBox(height: 6.h),

                // Validity
                Text(
                  "Validity: ${formatDateTime(tx.validityStart)} → ${formatDateTime(tx.validityEnd)}",
                  style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                ),
                SizedBox(height: 6.h),

                // Status
                Row(
                  children: [
                    const Icon(Icons.info_outline,
                        color: Colors.white54, size: 16),
                    SizedBox(width: 5.w),
                    Text(
                      "Status: ${tx.status}",
                      style: TextStyle(
                        color: tx.status == "expired"
                            ? Colors.redAccent
                            : tx.status == "cancelled"
                            ? Colors.orangeAccent
                            : Colors.greenAccent,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String formatDateTime(DateTime? dateStr) {
    try {
      return DateFormat("dd MMM yyyy, hh:mm a").format(dateStr!);
    } catch (e) {
      return dateStr!.toIso8601String();
    }
  }
}
