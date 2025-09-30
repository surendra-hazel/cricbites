import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/core/constants/app_images.dart';
import 'package:Cricbites/features/search/presentation/controller/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchScreenController controller = Get.find<SearchScreenController>();

  @override
  String get searchFieldLabel => "Search Here";

  @override
  TextStyle? get searchFieldStyle =>
      TextStyle(color: Colors.white, fontSize: 15.sp);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      scaffoldBackgroundColor: AppColors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white38, fontSize: 15.sp),
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        TextButton(
          onPressed: () => query = "",
          child: const Text("Clear", style: TextStyle(color: Colors.white54)),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close, color: Colors.white),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = controller.search(query);

    return Container(
      color: AppColors.black,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.h),
          Text(
            "Top Searches",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
          SizedBox(height: 15.h),
          Expanded(
            child: ListView.separated(
              itemCount: results.length,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final item = results[index];
                return Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.r),
                      child: Image.asset(
                        AppImages.appLogo,
                        height: 40.h,
                        width: 40.w,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item,
                            style: TextStyle(
                                color: Colors.white, fontSize: 14.sp),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "News",
                            style: TextStyle(
                                color: Colors.white38, fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = controller.search(query);

    return Container(
      color: AppColors.black,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: ListView.separated(
        itemCount: results.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final item = results[index];
          return Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white.withOpacity(0.8),width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: Image.asset(
                    AppImages.appLogo,
                    height: 40.h,
                    width: 40.w,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item,
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "News",
                      style:
                      TextStyle(color: Colors.white38, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
