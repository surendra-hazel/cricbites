import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllTeamsScreen extends StatefulWidget {
  const AllTeamsScreen({super.key});

  @override
  State<AllTeamsScreen> createState() => _AllTeamsScreenState();
}

class _AllTeamsScreenState extends State<AllTeamsScreen> {
  int selectedTab = 0;
  final List<String> tabs = [
    "All Team",
    "International",
    "T20 League",
    "Domestic"
  ];

  final List<Map<String, String>> teams = [
    {"name": "India", "flag": "https://flagcdn.com/w40/in.png"},
    {"name": "Australia", "flag": "https://flagcdn.com/w40/au.png"},
    {"name": "England", "flag": "https://flagcdn.com/w40/gb.png"},
    {"name": "New Zealand", "flag": "https://flagcdn.com/w40/nz.png"},
    {"name": "South Africa", "flag": "https://flagcdn.com/w40/za.png"},
    {"name": "West Indies", "flag": "https://flagcdn.com/w40/jm.png"},
    {"name": "Sri Lanka", "flag": "https://flagcdn.com/w40/lk.png"},
    {"name": "Pakistan", "flag": "https://flagcdn.com/w40/pk.png"},
    {"name": "Afghanistan", "flag": "https://flagcdn.com/w40/af.png"},
    {"name": "Ireland", "flag": "https://flagcdn.com/w40/ie.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1221),
      appBar: CommonAppBar(
        titleText: "All Teams",
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
                      hintText: "Search Team",
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
                        radius: 16.r,
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
                        Icons.notifications_none,
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
