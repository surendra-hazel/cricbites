import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdownField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;

  const CustomDropdownField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.items,
    this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.transparent,
        border: Border.all(color: AppColors.white.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Row(
            children: [
              Icon(icon, color: AppColors.white),
              SizedBox(width: 9.w),
              Container(width: 0.2, height: 24.h, color: AppColors.white),
              SizedBox(width: 9.w),
              Text(
                hintText,
                style: const TextStyle(color: AppColors.textFieldHintColor),
              ),
            ],
          ),
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.white),
          dropdownColor: AppColors.primaryColor,
          isExpanded: true,
          items: items.map((String val) {
            return DropdownMenuItem(
              value: val,
              child: Text(val, style: const TextStyle(color: AppColors.white)),
            );
          }).toList(),

          // 👇 yaha custom selected view ban raha hai
          selectedItemBuilder: (BuildContext context) {
            return items.map((String val) {
              return Row(
                children: [
                  Icon(icon, color: AppColors.white),
                  SizedBox(width: 9.w),
                  Container(width: 0.2, height: 24.h, color: AppColors.white),
                  SizedBox(width: 9.w),
                  Text(
                    val,
                    style: const TextStyle(color: AppColors.white),
                  ),
                ],
              );
            }).toList();
          },

          onChanged: onChanged,
        ),
      ),
    );
  }
}


// class CustomDropdownField extends StatelessWidget {
//   final IconData icon;
//   final String hintText;
//   final List<String> items;
//   final String? value;
//   final Function(String?) onChanged;
//
//   const CustomDropdownField({
//     super.key,
//     required this.icon,
//     required this.hintText,
//     required this.items,
//     this.value,
//     required this.onChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.w),
//       decoration: BoxDecoration(
//         color: AppColors.transparent,
//         border: Border.all(color: AppColors.textFieldBorder),
//         borderRadius: BorderRadius.circular(50.r),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: value,
//           hint: Row(
//             children: [
//               Icon(icon, color: AppColors.white),
//               SizedBox(width: 9.w),
//               Container(width: 0.2, height: 24.h, color: AppColors.white),
//               SizedBox(width: 9.w),
//               Text(
//                 hintText,
//                 style: const TextStyle(color: AppColors.textFieldHintColor),
//               ),
//             ],
//           ),
//           icon: const Icon(Icons.arrow_drop_down, color: AppColors.white),
//           dropdownColor: AppColors.primaryColor,
//           isExpanded: true,
//           items: items.map((String val) {
//             return DropdownMenuItem(
//               value: val,
//               child: Text(val, style: const TextStyle(color: AppColors.white)),
//             );
//           }).toList(),
//           onChanged: onChanged,
//         ),
//       ),
//     );
//   }
// }
