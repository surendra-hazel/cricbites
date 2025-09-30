import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/core/constants/app_constants.dart';
import 'package:Cricbites/core/constants/app_strings.dart';
import 'package:Cricbites/core/routes/app_routes.dart';
import 'package:Cricbites/features/more/presentation/controller/more_controller.dart';
import 'package:Cricbites/features/profile/controller/profile_controller.dart';
import 'package:Cricbites/features/set_profile/presentation/controllers/set_profile_controller.dart';
import 'package:Cricbites/widgets/common_alert_popup.dart';
import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:Cricbites/widgets/custom_text_field.dart';
import 'package:Cricbites/widgets/image_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final moreController = Get.put(MoreController());
    Get.put(SetProfileController());
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CommonAppBar(
        titleText: "Profile",
        showBackButton: true,
        actions: [
          IconButton(
            onPressed: () async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CommonAlertPopup(
            title: "Are you sure?",
            onClose: () => Navigator.of(context).pop(),
            onYes: (){
              Navigator.of(context).pop(true);
              moreController.logoutUser();
            },
            onNo: () => Navigator.of(context).pop(false),
            yesChild: Text("logout",
                style: TextStyle(
                    color: Colors.black, fontSize: 16.sp)),
            noChild: Text("No",
                style: TextStyle(
                    color: Colors.white, fontSize: 16.sp)),
          );
        },
      );
    },
            icon: Icon(Icons.logout, color: AppColors.white, size: 26.sp),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          padding: EdgeInsets.all(15.w),
          children: [
            const AvatarPicker(
              showEditIcon: false,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    controller.nameController.text.capitalizeFirst.toString(),
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final result = await Get.toNamed(
                      AppRoutes.editProfile,
                      arguments: {
                        "name": controller.nameController.text,
                        "username": controller.userNameController.text,
                        "city": controller.cityController.text,
                        "dob": controller.dateOfBirthController.text,
                        "gender": controller.genderController.text,
                        "country": controller.countryController.text,
                        "bio": controller.bioController.text,
                      },
                    );

                    if (result == true) {
                      controller.fetchUserProfile();
                    }
                  },
                  child: Container(
                      padding: EdgeInsets.all(05.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(08.r),
                        // shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.white,
                        ),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: AppColors.white,
                        size: 15.w,
                      )),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.all(10.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.activePlan!.value.planName != null &&
                                controller.activePlan!.value.planName!.isNotEmpty
                            ? "Current Active Plan"
                            : "No Active plan",
                        style: TextStyle(
                          color: AppColors.buttonTop,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      controller.activePlan!.value.planName != null &&
                          controller.activePlan!.value.planName!.isNotEmpty
                          ?const SizedBox():Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          gradient:  const RadialGradient(colors: [
                            AppColors.buttonBottom,
                            AppColors.buttonTop,
                          ], radius: 2.0,
                              center: Alignment.centerRight),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Subscribe",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  controller.activePlan!.value.planName != null &&
                          controller.activePlan!.value.planName!.isNotEmpty
                      ? Text(
                          controller.activePlan!.value.planName!,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : const SizedBox(),
                  controller.activePlan!.value.planName != null &&
                      controller.activePlan!.value.planName!.isNotEmpty
                      ? Text(
                    controller.activePlan!.value.description!,
                    style: TextStyle(
                      color: AppColors.white.withOpacity(0.6),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                      : const SizedBox(),
                  controller.activePlan!.value.planName != null &&
                      controller.activePlan!.value.planName!.isNotEmpty
                      ? Obx(() {
                    final plan = controller.activePlan!.value;
                    if (plan.validityEnd == null) return const SizedBox();
                    DateTime nextPaymentDate =
                        plan.validityEnd!.add(const Duration(days: 1));
                    String formattedNextPayment =
                        DateFormat("dd MMM yyyy").format(nextPaymentDate);
                    return Text("Next Payment Date: $formattedNextPayment",
                        style: const TextStyle(color: AppColors.red));
                  }):const SizedBox(),
                  controller.activePlan!.value.planName != null &&
                      controller.activePlan!.value.planName!.isNotEmpty
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          gradient:  const RadialGradient(colors: [
                            AppColors.buttonBottom,
                            AppColors.buttonTop,
                          ], radius: 2.0,
                              center: Alignment.centerRight),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Upgrade Plan",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ):const SizedBox(),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            buildMenuItem(icon: Icons.receipt_long, title: "Subscription History", onTap: (){
              Get.toNamed(
                AppRoutes.transaction,
                arguments: controller.subscribeTransaction,
              );
            }),


            SizedBox(height: 10.h),
            buildMenuItem(icon: Icons.diversity_2_outlined, title: "Refer List", onTap: (){
              Get.toNamed(AppRoutes.referList);
            }),
            SizedBox(height: 10.h),
            buildMenuItem(icon: Icons.group_add, title: "Invite Friend", onTap: (){
              Get.toNamed(
                AppRoutes.inviteFriend,
                arguments: controller.referralCode.value,
              );
            }),
            SizedBox(height: 10.h),
            buildMenuItem(icon: Icons.help_outline, title: "Help", onTap: () {
              Get.toNamed(AppRoutes.webView,arguments: "${AppConstants.baseWebviewUrl}about-us/?app=1",);
            }),SizedBox(height: 30.h),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return CommonAlertPopup(
                      title: "Are you sure?",
                      onClose: () => Navigator.of(context).pop(),
                      onYes: () => Navigator.of(context).pop(true),
                      onNo: () => Navigator.of(context).pop(false),
                      yesChild: Text("Yes",
                          style:
                              TextStyle(color: Colors.black, fontSize: 16.sp)),
                      noChild: Text("No",
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp)),
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.white.withOpacity(0.6)),
                  borderRadius: BorderRadius.circular(50.r),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Text(
                  "Delete Account",
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isTop = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color:
        isTop ? AppColors.white.withOpacity(0.2) : AppColors.primaryColor,
        border: const Border(
          bottom: BorderSide(color: AppColors.black, width: 1.6),
        ),
      ),
      child: ListTile(
        leading: isTop
            ? Card(
          color: AppColors.white.withOpacity(0.7),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(06.r)),
          child: Icon(
            icon,
            color: AppColors.black,
          ),
        )
            : Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white70),
        onTap: onTap,
      ),
    );
  }

}


/*CustomTextField(
              icon: Icons.person,
              controller: controller.nameController,
              hintText: AppStrings.fullName,
              readOnly: true,
            ),
            SizedBox(height: 13.h),

            CustomTextField(
              icon: Icons.account_circle_rounded,
              controller: controller.userNameController,
              hintText: AppStrings.userName,
              readOnly: true,
            ),
            SizedBox(height: 13.h),

            CustomTextField(
              icon: Icons.male,
              controller: controller.genderController,
              readOnly: true,
              hintText: "Select Gender",
            ),
            SizedBox(height: 13.h),

            CustomTextField(
              icon: Icons.location_on_outlined,
              controller: controller.countryController,
              readOnly: true,
              hintText: "Select Country",
            ),
            SizedBox(height: 13.h),

            CustomTextField(
              icon: Icons.location_city,
              controller: controller.cityController,
              readOnly: true,
              hintText: AppStrings.enterCity,
            ),
            SizedBox(height: 13.h),

            CustomTextField(
              icon: Icons.calendar_month,
              controller: controller.dateOfBirthController,
              readOnly: true,
              hintText: "Date of Birth",
            ),
            SizedBox(height: 13.h),

            CustomTextField(
              icon: Icons.edit_note,
              controller: controller.bioController,
              readOnly: true,
              hintText: AppStrings.bio,
              maxLine: 3,
            ),*/