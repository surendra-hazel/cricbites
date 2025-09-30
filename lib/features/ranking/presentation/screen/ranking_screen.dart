import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/core/constants/app_images.dart';
import 'package:Cricbites/features/ranking/data/modal/icc_ranking_modal.dart';
import 'package:Cricbites/features/ranking/presentation/controller/ranking_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _ICCRankingScreenState();
}
class _ICCRankingScreenState extends State<RankingScreen> {
  final List<String> genders = ["Men", "Women"];
  final List<String> gendersImages = [AppImages.men, AppImages.women];
  final List<String> categories = [
    "Teams",
    "Batting",
    "Bowling",
    "All Rounder",
  ];
  final List<String> formats = ["TEST", "ODI", "T20I"];
  final controller = Get.put(RankingController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fetchRanking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1221),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1221),
        elevation: 0,
        leading: const BackButton(color: AppColors.white),
        leadingWidth: 25.w,
        title: Text(
          "ICC Rankings",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16.sp,
          ),
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              border: Border.all(color: AppColors.textFieldBorder),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() => Row(
                    children: List.generate(genders.length, (index) {
                      final isSelected =
                          index == controller.selectedGender.value;
                      return GestureDetector(
                        onTap: () {
                          controller.changeGender(index);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.white.withOpacity(0.12)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.textFieldBorder
                                  : AppColors.transparent,
                            ),
                          ),
                          child: Row(
                            children: [
                              Image(image: AssetImage(gendersImages[index])),
                              const SizedBox(width: 10),
                              Text(
                                genders[index],
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  )),
            ),
          ),
        ],
      ),
      body: Obx(() {
        return Column(
          children: [
            Container(
              height: 60.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: const BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(color: AppColors.textFieldBorder),
                ),
                color: AppColors.primaryColor,
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final isSelected = index == controller.selectedCategory.value;
                  return GestureDetector(
                    onTap: () {
                      controller.changeCategory(index);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? const LinearGradient(
                                colors: [
                                  AppColors.buttonTop,
                                  AppColors.buttonBottom,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )
                            : const LinearGradient(
                                colors: [
                                  AppColors.transparent,
                                  AppColors.transparent,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.textFieldBorder,
                        ),
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 06.w, horizontal: 40.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(
                  color: AppColors.textFieldBorder,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(formats.length, (index) {
                  final isSelected = index == controller.selectedFormat.value;
                  return GestureDetector(
                    onTap: () {
                      controller.changeFormat(index);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.w, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.white.withOpacity(0.12)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.white.withOpacity(0.5)
                              : AppColors.transparent,
                        ),
                      ),
                      child: Text(
                        formats[index],
                        style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            /// --- Table Header
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.buttonTop,
                    AppColors.buttonBottom,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.only(
                  top: 10, left: 04, right: 04, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                      flex: 1,
                      child: Text("Rank",
                          style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.white))),
                  SizedBox(
                    width: 10.w,
                  ),
                  controller.selectedCategory.value == 0
                      ? const Expanded(
                          flex: 5,
                          child: Text("Team",
                              style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.white)))
                      : const Expanded(
                          flex: 5,
                          child: Text("Player",
                              style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.white))),
                  Expanded(
                      flex: controller.selectedCategory.value==0?2:1,
                      child: const Text("Rating",
                          style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.white))),
                  controller.selectedCategory.value == 0
                      ? const Expanded(
                          flex: 2,
                          child: Text("Points",
                              style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.white)))
                      : const SizedBox(),
                ],
              ),
            ),

            /// --- Ranking List
            Expanded(
              child: controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.dataList.isEmpty
                      ? const Center(
                          child: Text("No data available",
                              style: TextStyle(color: Colors.white)),
                        )
                      : ListView.builder(
                          itemCount: controller.dataList.length,
                          itemBuilder: (context, index) {
                            final listData = controller.dataList[index];

                            if (listData is AllRoundersOdi) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.white.withOpacity(0.2)),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Text("${index + 1}",
                                            style: const TextStyle(
                                                color: Colors.white))),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 12.r,
                                            backgroundColor: AppColors.white.withOpacity(0.12),
                                            child: const Icon(Icons.person,color: AppColors.white,size: 18,),
                                            // backgroundImage: NetworkImage(
                                            //     "https://flagcdn.com/w40/in.png"),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            listData.player ??
                                                "N/A", // ✅ Safe access
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Text("${listData.rating ?? 0}",
                                            style: const TextStyle(
                                                color: Colors.white))),
                                    // Expanded(flex: 2, child: Text("${listData.rating ?? 0}", style: const TextStyle(color: Colors.white))),
                                  ],
                                ),
                              );
                            } else if (listData is TeamsOdi) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.white.withOpacity(0.2)),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Text("${index + 1}",
                                            style: const TextStyle(
                                                color: Colors.white))),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 12,
                                            backgroundImage: NetworkImage(listData.logoUrl??"https://flagcdn.com/w40/in.png"),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            listData.team ??
                                                "N/A", // ✅ Safe access
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Text("${listData.rating ?? 0}",
                                            style: const TextStyle(
                                                color: Colors.white))),
                                    Expanded(
                                        flex: 2,
                                        child: Text("${listData.points ?? 0}",
                                            style: const TextStyle(
                                                color: Colors.white))),
                                  ],
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
            ),
          ],
        );
      }),
    );
  }
}
