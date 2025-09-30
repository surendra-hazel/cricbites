import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/core/constants/app_constants.dart';
import 'package:Cricbites/core/routes/app_routes.dart';
import 'package:Cricbites/features/all_series/presentation/controller/all_series_controller.dart';
import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AllSeriesScreen extends StatefulWidget {
  const AllSeriesScreen({super.key});

  @override
  State<AllSeriesScreen> createState() => _AllSeriesScreenState();
}

class _AllSeriesScreenState extends State<AllSeriesScreen> {
  int selectedTab = 0;
  final AllSeriesController controller = Get.put(AllSeriesController());
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fetchSeriesList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1221),
      appBar: CommonAppBar(
        titleText: "All Series",
        showBackButton: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            /// Tabs
            Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categoryList.length,
                itemBuilder: (context, index) {
                  final isSelected = index == controller.selectedCategory.value;
                  return GestureDetector(
                    onTap: () => controller.changeCategory(index),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      child: Text(
                        controller.categoryList[index],
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.white
                              : AppColors.white.withOpacity(0.5),
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            /// Search Box
            Container(
              margin: EdgeInsets.all(12.w),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(color: AppColors.textFieldBorder),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.white70),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Search Series",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        controller.searchQuery.value = value;
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      searchController.clear();
                      controller.searchQuery.value = "";
                    },
                    child: const Text(
                      "Clear",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),

            /// Series List
            Expanded(
              child: ListView.builder(
                itemCount: controller.filteredItems.length,
                itemBuilder: (context, index) {
                  final item = controller.filteredItems[index];
                  return GestureDetector(
                    onTap: (){
                      // print("${AppConstants.baseWebviewUrl}category/${generateSlug(item.title!)}?app=1");
                      Get.toNamed(AppRoutes.webView,arguments: "${AppConstants.baseWebviewUrl}category/${generateSlug(item.title!)}?app=1");
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Month Heading
                        Container(
                          width: double.infinity,
                          color: Colors.white.withOpacity(0.08),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
                          child: Text(
                            formatMonthYear(item.datestart!) ?? "",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    
                        /// Series Tile
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.white.withOpacity(0.1)),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "${formatShortMonthDay(item.datestart)} - ${formatShortMonthDay(item.dateend)}",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
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

  String? formatMonthYear(DateTime? date) {
    if (date == null) return null;
    return DateFormat('MMMM yyyy').format(date);
  }

  String? formatShortMonthDay(DateTime? date) {
    if (date == null) return null;
    return DateFormat('MMM d').format(date);
  }

  String generateSlug(String title) {
    return title
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .trim();
  }
}
