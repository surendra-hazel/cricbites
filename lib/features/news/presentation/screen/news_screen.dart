import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Cricbites/core/constants/app_colors.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int selectedTab = 0;

  final List<String> topTabs = [
    "Trending",
    "Latest Articles",
    "Category",
    "Entertainment",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        title: const Text(
          "News",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Top Tabs
          const Divider(color: AppColors.textFieldBorder),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(topTabs.length, (index) {
                  final isSelected = index == selectedTab;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTab = index),
                      child: Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
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
                          border: Border.all(color: Colors.grey.shade600),
                        ),
                        child: Text(
                          topTabs[index],
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.white,
                            fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          /// --- News List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              separatorBuilder: (_, __) =>
              const SizedBox(height: 12), // spacing
              itemCount: 6,
              itemBuilder: (context, index) {
                if (index == 1) {
                  return _adsBlock();
                }
                return _newsCard();
              },
            ),
          ),
        ],
      ),
    );
  }

  /// --- Reusable News Card
  Widget _newsCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.white.withOpacity(0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Image
          Expanded(
            // flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  "https://www.hindustantimes.com/ht-img/img/2023/04/21/550x309/PTI04-17-2023-000332B-0_1682055940186_1682055966096.jpg",
                  height: 100.h,
                  // width: 200.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          /// Content
          Expanded(
            // flex: 2,
            child: Container(
              // width: 150.w,
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "PAK Women vs IRE Women: 1st T20I, Full Scorecard, Live Updates",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          color: AppColors.white.withOpacity(0.7), size: 14),
                      const SizedBox(width: 4),
                      Text(
                        "27 JUN 2025",
                        style: TextStyle(
                            color: AppColors.white.withOpacity(0.7),
                            fontSize: 10.sp),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.access_time,
                          color: AppColors.white.withOpacity(0.7), size: 14),
                      // const SizedBox(width: 4),
                      Text(
                        "2 min",
                        style: TextStyle(
                            color: AppColors.white.withOpacity(0.7),
                            fontSize: 10.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// --- ADS Block
  Widget _adsBlock() {
    return Container(
      height: 120,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        "ADS",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
