import 'package:Cricbites/features/promote/presentation/controller/promoter_app_controller.dart';
import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:Cricbites/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:Cricbites/core/constants/app_colors.dart';

class PromoteAppDetailScreen extends StatelessWidget {
  const PromoteAppDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PromoteAppController());

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CommonAppBar(
        titleText: "Promote App",
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("Basic Details"),
            SizedBox(height: 10.h),
            _buildTextField(
              "Full Name",
              controller.nameController,
              textInputType: TextInputType.name,
            ),
            SizedBox(height: 12.h),
            _buildTextField(
              "Email Address *",
              controller.emailController,
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(height: 12.h),
            _buildTextField(
              "Mobile Number",
              controller.mobileController,
              textInputType: TextInputType.phone,
              maxLength: 10,
            ),
            SizedBox(height: 12.h),
            _buildTextField(
              "City",
              controller.cityController,
              textInputType: TextInputType.streetAddress,
            ),
            SizedBox(height: 12.h),
            _buildTextField(
              "State",
              controller.stateController,
              textInputType: TextInputType.streetAddress,
            ),

            SizedBox(height: 20.h),

            // Add channel button
            CustomButton(
              text: "+ Add Channel Details",
              onPressed: controller.addChannel,
            ),

            SizedBox(height: 16.h),

            // Multiple channel sections
            Obx(
              () => Column(
                children: List.generate(controller.channels.length, (index) {
                  final channel = controller.channels[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _buildLabel("Channel ${index + 1}"),
                            const Spacer(),
                            IconButton(
                              onPressed: () => controller.removeChannel(index),
                              icon: const Icon(Icons.delete,
                                  color: AppColors.red),
                            )
                          ],
                        ),
                        SizedBox(height: 10.h),
                        _buildTextField("Type", channel.typeController),
                        SizedBox(height: 12.h),
                        _buildTextField("Channel Name", channel.nameController),
                        SizedBox(height: 12.h),
                        _buildTextField("Channel URL", channel.urlController),
                        SizedBox(height: 12.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              controller.saveChannel(index);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.r),
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.buttonTop,
                                    AppColors.buttonBottom,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Text(
                                "Save channel",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            SizedBox(height: 30.h),

            // Submit button
            Obx(
              (){
                return CustomButton(text: "Submit", onPressed: controller.submitDetails,isLoading: controller.isLoading.value,);
              }
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller,
      {int? maxLength, TextInputType? textInputType}) {
    return TextField(
      controller: controller,
      maxLength: maxLength ?? 50,
      keyboardType: textInputType ?? TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        counterText: "",
        fillColor: AppColors.primaryColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
