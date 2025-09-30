import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/core/constants/app_constants.dart';
import 'package:Cricbites/features/home/presentation/screens/home_screen.dart';
import 'package:Cricbites/features/more/presentation/screen/more_screen.dart';
import 'package:Cricbites/features/schedule/presentation/screen/schedule_screen.dart';
import 'package:Cricbites/features/shorts/presentation/screen/shorts_screen.dart';
import 'package:Cricbites/widgets/web_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() =>
      _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    // const WebViewScreen(
    //   key: ValueKey("homeWebView"),
    //   url: "${AppConstants.baseWebviewUrl}?app=1",
    // ),
    const HomeScreen(),
    const ScheduleScreen(),
    const ShortsScreen(),
    // const WebViewScreen(
    //   key: ValueKey("storyWebView"),
    //   url: "${AppConstants.baseWebviewUrl}web-stories/?app=1",
    // ),
    const WebViewScreen(
      key: ValueKey("newsWebView"),
      url: "${AppConstants.baseWebviewUrl}category/cricket-news/?app=1",
    ),
    const MoreScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        height: 90.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.r),
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
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.white.withOpacity(0.6),
          currentIndex: _selectedIndex,
          onTap: onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "Schedule",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_fill),
              label: "Shorts",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: "News",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: "More",
            ),
          ],
        ),
      ),
    );
  }
}
