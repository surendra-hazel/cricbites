import 'dart:ui';
import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  final List<Map<String, String>> stories = const [
    {
      "title":
      "Top 5 Indian Test Captains with most runs in debut series as captain",
      "image":
      "https://images1.dnaindia.com/images/DNA-EN/900x1600/2023/9/26/1695748290240_desktopwallpaperdhonimsdhoniindia.jpg"
    },
    {
      "title": "Virat Kohli's most iconic centuries in Tests",
      "image":
      "https://images.unsplash.com/photo-1606112219348-204d7d8b94ee"
    },
    {
      "title": "Top 10 World Cup moments in Cricket",
      "image":
      "https://images.unsplash.com/photo-1521412644187-c49fa049e84d"
    },
    {
      "title": "Most memorable IPL finals of all time",
      "image":
      "https://images.unsplash.com/photo-1549924231-f129b911e442"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: const BackButton(color: AppColors.white,),
        title: const Text(
          "Stories",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: GridView.builder(
          itemCount: stories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 250.w / 300.h,
          ),
          itemBuilder: (context, index) {
            final story = stories[index];
            return _storyItem(story["title"]!, story["image"]!);
          },
        ),
      ),
    );
  }

  Widget _storyItem(String title, String imageUrl) {
    return Container(
      height: 300.h,
      width: 250.w,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.r),
        border: Border.all(color: AppColors.textFieldBorder),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.5),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(13.r)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(13.r)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Text(
                title,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
