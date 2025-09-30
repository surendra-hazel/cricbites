import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/features/refer_list/presentation/controller/refer_list_controller.dart';
import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReferListScreen extends StatelessWidget {
  const ReferListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReferListController());

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CommonAppBar(
        titleText: "Refer List",
        showBackButton: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.referList.isEmpty) {
          return const Center(
              child: Text("No referrals found",
                  style: TextStyle(color: Colors.white)));
        }

        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              margin: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Users: ${controller.totalUser.value}",
                      style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                  Text("Total Amount: ₹${controller.totalAmount.value}",
                      style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.referList.length,
                itemBuilder: (context, index) {
                  final user = controller.referList[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.buttonTop,
                          child: Text(user.name![0].toUpperCase(),
                              style: const TextStyle(color: Colors.black)),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.name!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp)),
                              Text(user.mobile!,
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 14.sp)),
                            ],
                          ),
                        ),
                        Text("₹${user.amount}",
                            style: TextStyle(
                                color: AppColors.buttonTop,
                                fontWeight: FontWeight.w700,
                                fontSize: 15.sp)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
