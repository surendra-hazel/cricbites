import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllVideosScreen extends StatelessWidget {
  const AllVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1221),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1221),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "All Videos",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Shorts Section
            _sectionTitle("Cricbites Shorts"),
            SizedBox(height: 10.h),
            SizedBox(
              height: 160.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                separatorBuilder: (_, __) => SizedBox(width: 10.w),
                itemBuilder: (context, index) {
                  return _shortCard();
                },
              ),
            ),

            SizedBox(height: 20.h),

            /// Trending Video
            _sectionTitle("Trending Video"),
            SizedBox(height: 10.h),
            SizedBox(
              height: 280.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemBuilder: (context, index) {
                  return _videoCard();
                },
              ),
            ),

            SizedBox(height: 20.h),

            /// Cricbites Special
            _sectionTitle("Cricbites Special"),
            SizedBox(height: 10.h),
            SizedBox(
              height: 280.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemBuilder: (context, index) {
                  return _videoCard();
                },
              ),
            ),

            SizedBox(height: 20.h),

            /// ODI Special
            _sectionTitle("ODI Special"),
            SizedBox(height: 10.h),
            SizedBox(
              height: 280.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemBuilder: (context, index) {
                  return _videoCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// --- Section Title Reusable
  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: AppColors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// --- Short Card Reusable
  Widget _shortCard() {
    return Container(
      width: 120.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primaryColor,
        image: DecorationImage(
          image: NetworkImage("https://t3.ftcdn.net/jpg/05/10/55/58/360_F_510555809_gSP39J8OgWzaMf21CTnqV7CTXU12rP3K.jpg"), // dummy
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.7), Colors.transparent],
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            "Battle Begins 🔥\nBy Cricket Club\nCredits: 🏏",
            style: TextStyle(color: AppColors.white, fontSize: 12.sp),
          ),
        ),
      ),
    );
  }

  /// --- Video Card Reusable
  Widget _videoCard() {
    return Container(
      width: 280.w,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.white.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              "https://www.hindustantimes.com/ht-img/img/2023/11/12/550x309/India-Cricket-WCup-68_1699809986420_1699810043017.jpg",
              height: 150.h,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  "https://t3.ftcdn.net/jpg/05/10/55/58/360_F_510555809_gSP39J8OgWzaMf21CTnqV7CTXU12rP3K.jpg",
                  height: 150.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "7 Best Finishers in Cricket History (2025)",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  "In cricket, a match is not always won by the highest scorer or the most popular batsman on social media.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.white.withOpacity(0.7),
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 14, color: AppColors.white.withOpacity(0.7)),
                    SizedBox(width: 6.w),
                    Text(
                      "27 JUN 2025",
                      style: TextStyle(
                        color: AppColors.white.withOpacity(0.7),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
