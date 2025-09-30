import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/core/constants/app_strings.dart';
import 'package:Cricbites/features/edit_profile/controller/edit_profile_controller.dart';
import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:Cricbites/widgets/common_date_picker_widget.dart';
import 'package:Cricbites/widgets/common_dropdown_widget.dart';
import 'package:Cricbites/widgets/custom_button_widget.dart';
import 'package:Cricbites/widgets/custom_text_field.dart';
import 'package:Cricbites/widgets/image_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());
    controller.initData(Get.arguments);

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CommonAppBar(
        titleText: "Edit Profile",
        showBackButton: true,
        // actions: [
        //   Obx(() => IconButton(
        //     onPressed: controller.isLoading.value ? null : () => controller.updateProfile(),
        //     icon: controller.isLoading.value
        //         ? const CircularProgressIndicator(color: Colors.white)
        //         : Icon(Icons.check, color: AppColors.white, size: 26.sp),
        //   )),
        // ],
      ),
      body: Obx(() =>  Container(
        padding: EdgeInsets.all(15.w),
        child: ListView(
          children: [
            SizedBox(height: 20.h),
            const AvatarPicker(showEditIcon: true),
            SizedBox(height: 20.h),

            CustomTextField(
              icon: Icons.person,
              controller: controller.nameController,
              hintText: AppStrings.fullName,
              keyboardType: TextInputType.name,
              maxLength: 30,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
              ],
            ),
            SizedBox(height: 13.h),

            CustomTextField(
              icon: Icons.account_circle_rounded,
              controller: controller.userNameController,
              hintText: AppStrings.userName,
              keyboardType: TextInputType.text,
              maxLength: 30,
            ),
            SizedBox(height: 13.h),

            CustomDropdownField(
              icon: Icons.transgender,
              hintText: "Select Gender",
              items: ["Male", "Female", "Other"],
              value: controller.selectedGender.value,
              onChanged: (val) => controller.selectedGender.value = val ?? "",
            ),
            SizedBox(height: 13.h),

            CustomDropdownField(
              icon: Icons.location_on_outlined,
              hintText: "Select Country",
              items: ["India", "USA", "UK", "Canada"],
              value: controller.selectedCountry.value,
              onChanged: (val) => controller.selectedCountry.value = val ?? "",
            ),
            SizedBox(height: 13.h),

            CustomTextField(
              icon: Icons.location_city,
              controller: controller.cityController,
              hintText: AppStrings.enterCity,
              keyboardType: TextInputType.streetAddress,
              maxLength: 30,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
              ],
            ),
            SizedBox(height: 13.h),

            CustomDateField(
              icon: Icons.calendar_month,
              hintText: "Date of Birth",
              controller: controller.dateOfBirthController,
            ),
            SizedBox(height: 13.h),

            CustomTextField(
              icon: Icons.edit_note,
              controller: controller.bioController,
              hintText: AppStrings.bio,
              keyboardType: TextInputType.multiline,
              maxLine: 3,
            ),
            SizedBox(height: 30.h),

            CustomButton(
              text: "Save Profile",
              isLoading: controller.isLoading.value,
              onPressed: controller.updateProfile,
            ),
          ],
        ),
      )),
    );
  }
}



// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});
//
//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }
//
// class _EditProfileScreenState extends State<EditProfileScreen> {
//   final TextEditingController nameController = TextEditingController(text: "Rohan Pandey");
//   final TextEditingController userNameController = TextEditingController(text: "Rohan@25");
//   final TextEditingController cityController = TextEditingController(text: "Jaipur");
//   final TextEditingController bioController = TextEditingController(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.");
//   final TextEditingController dateOfBirthController = TextEditingController(text: "15-02-93");
//
//   String? selectedGender = "Male";
//   String? selectedCountry = "India";
//
//   final List<String> genders = ["Male", "Female", "Other"];
//   final List<String> countries = ["India", "USA", "UK", "Canada"];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     final args = Get.arguments as Map<String, dynamic>?;
//
//     if (args != null) {
//       nameController.text = args["name"] ?? "";
//       userNameController.text = args["username"] ?? "";
//       cityController.text = args["city"] ?? "";
//       bioController.text = args["bio"] ?? "";
//       dateOfBirthController.text = args["dob"] ?? "";
//       selectedGender = args["gender"];
//       selectedCountry = args["country"];
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.black,
//       appBar: CommonAppBar(
//         titleText: "Edit Profile",
//         showBackButton: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               Get.back();
//             },
//             icon: Icon(
//               Icons.check,
//               color: AppColors.white,
//               size: 26.sp,
//             ),
//           ),
//         ],
//       ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         color: AppColors.black,
//         child: Column(
//           children: [
//             Expanded(
//               child: bodyPart(context),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget bodyPart(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(15.w),
//       child: ListView(
//         children: [
//           SizedBox(height: 20.h),
//           const AvatarPicker(showEditIcon: true,), // profile picture
//           SizedBox(height: 20.h),
//
//           // Full Name
//           CustomTextField(
//             icon: Icons.person,
//             controller: nameController,
//             hintText: AppStrings.fullName,
//             keyboardType: TextInputType.name,
//             maxLength: 30,
//             inputFormatters: [
//               FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
//             ],
//           ),
//           SizedBox(height: 13.h),
//
//           // Username
//           CustomTextField(
//             icon: Icons.account_circle_rounded,
//             controller: userNameController,
//             hintText: AppStrings.userName,
//             keyboardType: TextInputType.text,
//             maxLength: 30,
//           ),
//           SizedBox(height: 13.h),
//
//           // Gender
//           CustomDropdownField(
//             icon: Icons.transgender,
//             hintText: "Select Gender",
//             items: genders,
//             value: selectedGender,
//             onChanged: (val) => setState(() => selectedGender = val),
//           ),
//           SizedBox(height: 13.h),
//
//           // Country
//           CustomDropdownField(
//             icon: Icons.location_on_outlined,
//             hintText: "Select Country",
//             items: countries,
//             value: selectedCountry,
//             onChanged: (val) => setState(() => selectedCountry = val),
//           ),
//           SizedBox(height: 13.h),
//
//           // City
//           CustomTextField(
//             icon: Icons.location_city,
//             controller: cityController,
//             hintText: AppStrings.enterCity,
//             keyboardType: TextInputType.streetAddress,
//             maxLength: 30,
//             inputFormatters: [
//               FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
//             ],
//           ),
//           SizedBox(height: 13.h),
//
//           // Date of Birth
//           CustomDateField(
//             icon: Icons.calendar_month,
//             hintText: "Date of Birth",
//             controller: dateOfBirthController,
//           ),
//           SizedBox(height: 13.h),
//
//           // Bio
//           CustomTextField(
//             icon: Icons.edit_note,
//             controller: bioController,
//             hintText: AppStrings.bio,
//             keyboardType: TextInputType.multiline,
//             maxLine: 3,
//           ),
//           SizedBox(height: 30.h),
//
//           // Save Button
//           CustomButton(
//             text: "Save Profile",
//             onPressed: () {
//               Get.toNamed(AppRoutes.bottomNavigation);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
