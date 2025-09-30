import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:Cricbites/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  final TextEditingController searchController = TextEditingController();


  final List<String> categories = [
    "India VS West Indies",
    "Oman D10 League 2024",
    "India VS West Indies",
    "Oman D10 League 2024",
    "India VS West Indies",
    "Oman D10 League 2024",
    "India VS West Indies",
    "Oman D10 League 2024",
  ];

  List<String> filteredCategories = [];

  @override
  void initState() {
    super.initState();
    filteredCategories = categories;
    searchController.addListener(_filterCategories);
  }

  void _filterCategories() {
    setState(() {
      filteredCategories = categories
          .where((cat) =>
          cat.toLowerCase().contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CommonAppBar(
        titleText: "All Category",
        showBackButton: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.vertical(
          //   top: Radius.circular(50.r),
          // ),
          // border: const Border(
          //   top: BorderSide(
          //     color: AppColors.white,
          //     width: 1.8,
          //   ),
          // ),
          // gradient: const LinearGradient(
          //   colors: [
          //     AppColors.bodyTop,
          //     AppColors.bodyBottom,
          //   ],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
        ),
        padding: EdgeInsets.all(15.w),
        child: Column(
          children: [
            SizedBox(height: 15.h),
            CustomTextField(
              controller: searchController,
              hintText: "Search Category",
              icon: Icons.search,
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.separated(
                itemCount: filteredCategories.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.white24,
                  height: 1.h,
                ),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      filteredCategories[index],
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16.sp,
                      color: Colors.white,
                    ),
                    onTap: () {
                      // TODO: Navigate to category details
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
