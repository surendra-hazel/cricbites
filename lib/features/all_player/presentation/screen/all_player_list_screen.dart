import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllPlayerScreen extends StatefulWidget {
  const AllPlayerScreen({super.key});

  @override
  State<AllPlayerScreen> createState() => _AllPlayerScreenState();
}

class _AllPlayerScreenState extends State<AllPlayerScreen> {
  int selectedTab = 0;
  final List<String> tabs = [
    "All Player",
    "International",
    "T20 League",
    "Domestic"
  ];

  final List<Map<String, String>> teams = [
    {"name": "Virat Kohli", "flag": "https://documents.iplt20.com/ipl/IPLHeadshot2025/2.png"},
    {"name": "Virat Kohli", "flag": "https://documents.iplt20.com/ipl/IPLHeadshot2025/2.png"},
    {"name": "Virat Kohli", "flag": "https://documents.iplt20.com/ipl/IPLHeadshot2025/2.png"},
    {"name": "Virat Kohli", "flag": "https://documents.iplt20.com/ipl/IPLHeadshot2025/2.png"},
    {"name": "Virat Kohli", "flag": "https://documents.iplt20.com/ipl/IPLHeadshot2025/2.png"},
    {"name": "Virat Kohli", "flag": "https://documents.iplt20.com/ipl/IPLHeadshot2025/2.png"},
    {"name": "Virat Kohlia", "flag": "https://documents.iplt20.com/ipl/IPLHeadshot2025/2.png"},
    {"name": "Virat Kohli", "flag": "https://documents.iplt20.com/ipl/IPLHeadshot2025/2.png"},
    {"name": "Virat Kohli", "flag": "https://documents.iplt20.com/ipl/IPLHeadshot2025/2.png"},
    {"name": "Virat Kohli", "flag": "https://documents.iplt20.com/ipl/IPLHeadshot2025/2.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1221),
      appBar: CommonAppBar(
        titleText: "All Player",
        showBackButton: true,
      ),
      body: Column(
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
              itemCount: tabs.length,
              itemBuilder: (context, index) {
                final isSelected = index == selectedTab;
                return GestureDetector(
                  onTap: () => setState(() => selectedTab = index),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        color: isSelected ? AppColors.white : AppColors.white.withOpacity(0.5),
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
                const Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Search Player",
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Clear",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),

          /// Teams List
          Expanded(
            child: ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                final team = teams[index];
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
                    ),
                  ),
                  child: Row(
                    children: [
                      /// Flag
                      CircleAvatar(
                        radius: 20.r,
                        backgroundColor: AppColors.transparent,
                        backgroundImage: NetworkImage(team["flag"]!),
                      ),
                      SizedBox(width: 12.w),

                      /// Team Name
                      Expanded(
                        child: Text(
                          team["name"]!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      /// Notification Bell
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white70,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
