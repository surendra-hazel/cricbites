import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/core/constants/app_constants.dart';
import 'package:Cricbites/core/constants/app_strings.dart';
import 'package:Cricbites/core/routes/app_routes.dart';
import 'package:Cricbites/features/set_profile/presentation/controllers/set_profile_controller.dart';
import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:Cricbites/widgets/common_date_picker_widget.dart';
import 'package:Cricbites/widgets/common_dropdown_widget.dart';
import 'package:Cricbites/widgets/custom_button_widget.dart';
import 'package:Cricbites/widgets/custom_text_field.dart';
import 'package:Cricbites/widgets/image_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SetProfileScreen extends StatelessWidget {
  SetProfileScreen({super.key});

  final SetProfileController controller = Get.put(SetProfileController());

  final List<String> genders = ["Male", "Female", "Other"];
  final List<String> countries = ["India", "USA", "UK", "Canada"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CommonAppBar(
        titleText: "",
        showBackButton: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.webView,arguments: "${AppConstants.baseWebviewUrl}about-us/?app=1",);
            },
            icon: Icon(
              Icons.help_outline,
              color: AppColors.white,
              size: 24.sp,
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppColors.black,
        child: Column(
          children: [
            headingPart(),
            Expanded(
              child: bodyPart(context),
            ),
          ],
        ),
      ),
    );
  }

  headingPart() {
    return SizedBox(
      height: 100.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.setProfile,
            style: TextStyle(
              fontSize: 26.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            AppStrings.createProfile,
            style: TextStyle(fontSize: 16.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }

  bodyPart(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50.r),
        ),
        border: const Border(
          top: BorderSide(
            color: AppColors.white,
            width: 1.8,
          ),
        ),
        gradient: const LinearGradient(
          colors: [
            AppColors.bodyTop,
            AppColors.bodyBottom,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.all(15.w),
      child: ListView(
        children: [
          SizedBox(height: 20.h),
          const AvatarPicker(showEditIcon: true,),
          SizedBox(height: 13.h),

          CustomTextField(
            icon: Icons.person,
            controller: controller.nameController,
            hintText: AppStrings.fullName,
            keyboardType: TextInputType.name,
            maxLength: 30,
          ),
          SizedBox(height: 13.h),

          CustomTextField(
            icon: Icons.account_circle_rounded,
            controller: controller.userNameController,
            hintText: AppStrings.userName,
            keyboardType: TextInputType.name,
            maxLength: 30,
          ),
          SizedBox(height: 13.h),

          Obx(() => CustomDropdownField(
            icon: Icons.male,
            hintText: "Select Gender",
            items: genders,
            value: controller.selectedGender.value.isEmpty
                ? null
                : controller.selectedGender.value,
            onChanged: (val) => controller.selectedGender.value = val!,
          )),
          SizedBox(height: 13.h),

          Obx(() => CustomDropdownField(
            icon: Icons.location_on_outlined,
            hintText: "Select Country",
            items: countries,
            value: controller.selectedCountry.value.isEmpty
                ? null
                : controller.selectedCountry.value,
            onChanged: (val) => controller.selectedCountry.value = val!,
          )),
          SizedBox(height: 13.h),

          CustomTextField(
            icon: Icons.location_city,
            controller: controller.cityController,
            hintText: AppStrings.enterCity,
            keyboardType: TextInputType.streetAddress,
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
            borderRadius: 20.r,
            maxLine: 3,
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 35.h),

          Obx(() => CustomButton(
            text:  AppStrings.continueText,
            isLoading: controller.isLoading.value,
            onPressed: controller.setProfile,
          )),
        ],
      ),
    );
  }
}


/*class SetProfileScreen extends StatefulWidget {
  const SetProfileScreen({super.key});

  @override
  State<SetProfileScreen> createState() => _SetProfileScreenState();
}

class _SetProfileScreenState extends State<SetProfileScreen> {
  final TextEditingController? nameController = TextEditingController();
  final TextEditingController? userNameController = TextEditingController();
  final TextEditingController? cityController = TextEditingController();
  final TextEditingController? bioController = TextEditingController();

  final TextEditingController? dateOfBirthController = TextEditingController();

  final TextEditingController? emailController = TextEditingController();

  final TextEditingController? phoneNumberController = TextEditingController();

  String? selectedGender;

  String? selectedCountry;

  final List<String> genders = ["Male", "Female", "Other"];

  final List<String> countries = ["India", "USA", "UK", "Canada"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CommonAppBar(
        titleText: "",
        showBackButton: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.help_outline,
              color: AppColors.white,
              size: 24.sp,
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // padding: EdgeInsets.all(12.h),
        color: AppColors.black,
        child: Column(
          children: [
            headingPart(),
            Expanded(
              child: bodyPart(context),
            ),
          ],
        ),
      ),
    );
  }

  headingPart() {
    return SizedBox(
      height: 100.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.setProfile,
            style: TextStyle(
              fontSize: 26.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            AppStrings.createProfile,
            style: TextStyle(fontSize: 16.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }

  bodyPart(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50.r),
        ),
        border: const Border(
          top: BorderSide(
            color: AppColors.white,
            width: 1.8,
          ),
        ),
        gradient: const LinearGradient(
          colors: [
            AppColors.bodyTop,
            AppColors.bodyBottom,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.all(15.w),
      child: ListView(
        children: [
          SizedBox(
            height: 20.h,
          ),
          const AvatarPicker(),
          SizedBox(
            height: 13.h,
          ),
          CustomTextField(
            icon: Icons.person,
            controller: nameController!,
            hintText: AppStrings.fullName,
            keyboardType: TextInputType.name,
            maxLength: 30,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z ]'),
              ),
            ],
          ),
          SizedBox(
            height: 13.h,
          ),
          CustomTextField(
            icon: Icons.account_circle_rounded,
            controller: userNameController!,
            hintText: AppStrings.userName,
            keyboardType: TextInputType.name,
            maxLength: 30,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z ]'),
              ),
            ],
          ),
          SizedBox(
            height: 13.h,
          ),
          CustomDropdownField(
            icon: Icons.male,
            hintText: "Select Gender",
            items: genders,
            value: selectedGender,
            onChanged: (val) => setState(() => selectedGender = val),
          ),
          SizedBox(height: 13.h),
          CustomDropdownField(
            icon: Icons.location_on_outlined,
            hintText: "Select Country",
            items: countries,
            value: selectedCountry,
            onChanged: (val) => setState(() => selectedCountry = val),
          ),
          SizedBox(
            height: 13.h,
          ),
          CustomTextField(
            icon: Icons.location_city,
            controller: cityController!,
            hintText: AppStrings.enterCity,
            keyboardType: TextInputType.streetAddress,
            maxLength: 30,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z ]'),
              ),
            ],
          ),
          SizedBox(height: 13.h),
          CustomDateField(
            icon: Icons.calendar_month,
            hintText: "Date of Birth",
            controller: dateOfBirthController!,
          ),
          SizedBox(
            height: 13.h,
          ),
          CustomTextField(
            icon: Icons.edit_note,
            controller: bioController!,
            hintText: AppStrings.bio,
            keyboardType: TextInputType.text,
            maxLength: 30,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z ]'),
              ),
            ],
          ),
          SizedBox(
            height: 35.h,
          ),
          CustomButton(
            text: AppStrings.continueText,
            onPressed: () {
              Get.toNamed(AppRoutes.bottomNavigation);
            },
          ),
        ],
      ),
    );
  }
}*/
