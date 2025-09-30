import 'package:Cricbites/features/feedback/presentation/controller/feedback_controller.dart';
import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:Cricbites/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Cricbites/core/constants/app_colors.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FeedbackController());

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CommonAppBar(
        titleText: "Feedback",
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Full Name", controller.nameController),
            _buildTextField("Email Address *", controller.emailController),
            _buildTextField(
              "Mobile Number",
              controller.mobileController,
              maxLength: 10,
              textInputType: TextInputType.phone,
            ),
            _buildDropdown("Category *", controller),
            _buildTextField("Subject *", controller.subjectController),
            _buildTextField("Description *", controller.descriptionController,
                maxLines: 5),
            SizedBox(height: 24.h),
            Obx(() => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.white))
                : CustomButton(
                    text: "Submit",
                    onPressed: controller.submitFeedback,
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1, int? maxLength, TextInputType? textInputType}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              )),
          TextField(
            controller: controller,
            maxLines: maxLines,
            maxLength: maxLength,
            keyboardType: textInputType ?? TextInputType.text,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: label,
              hintStyle: TextStyle(
                color: AppColors.white.withOpacity(0.4),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              filled: true,
              counterText: "",
              fillColor: AppColors.primaryColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, FeedbackController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              )),
          Obx(() => DropdownButtonFormField<String>(
                value: controller.selectedCategory.value.isEmpty
                    ? null
                    : controller.selectedCategory.value,
                items: const [
                  DropdownMenuItem(value: "bug", child: Text("Bug")),
                  DropdownMenuItem(
                      value: "feature", child: Text("Feature Request")),
                  DropdownMenuItem(value: "other", child: Text("Other")),
                ],
                onChanged: (value) {
                  controller.selectedCategory.value = value ?? "";
                },
                dropdownColor: AppColors.primaryColor,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.primaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
