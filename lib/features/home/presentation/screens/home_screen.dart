import 'dart:ui';

import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/core/constants/app_constants.dart';
import 'package:Cricbites/core/constants/app_images.dart';
import 'package:Cricbites/core/constants/app_prefs.dart';
import 'package:Cricbites/core/routes/app_routes.dart';
import 'package:Cricbites/features/home/presentation/controller/home_controller.dart';
import 'package:Cricbites/features/home/presentation/modal/home_modal.dart';
import 'package:Cricbites/features/search/presentation/controller/search_controller.dart';
import 'package:Cricbites/features/search/presentation/screen/search_screen.dart';
import 'package:Cricbites/widgets/common_alert_popup.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // final HomeController controller = Get.put(HomeController());
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => isLoading = true),
          onPageFinished: (_) => setState(() => isLoading = false),
        ),
      )
      ..loadRequest(Uri.parse("${AppConstants.baseWebviewUrl}?app=1"));
  }

  Future<bool> _handleBackPress() async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SearchScreenController());
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 18.0),
          child: Image(
            image: AssetImage(AppImages.appLogoHorizontal),
          ),
        ),
        leadingWidth: 120.w,
        backgroundColor: AppColors.black,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.webView,arguments: "${AppConstants.baseWebviewUrl}web-stories/?app=1",);
            },
            icon: Icon(
              Icons.slow_motion_video,
              color: AppColors.white,
              size: 28.w,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.webView,arguments: "https://www.cricbites.com/search/?app=1");
              // showSearch(
              //   context: context,
              //   delegate: CustomSearchDelegate(),
              // );
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white),
              ),
              child: Icon(
                Icons.search,
                color: AppColors.white,
                size: 15.w,
              ),
            ),
          ),
          SizedBox(width: 15.w),
          FutureBuilder<String?>(
            future: AppPrefs.getUserImage(),
            builder: (context, snapshot) {
              final imageUrl = snapshot.data;
              return GestureDetector(
                onTap: () {
                  _handleNavigation(AppRoutes.profile).then((_) {
                    setState(() {});
                  });
                },
                child: CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Colors.grey.shade800,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000.r),
                    child: imageUrl != null && imageUrl.isNotEmpty
                        ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: 40.w,
                      height: 40.w,
                    )
                        : const Icon(
                      Icons.person,
                      color: AppColors.white,
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(
            key: const ValueKey("homeWebView"),
            controller: _controller,
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(color: AppColors.white),
            ),
        ],
      ),
      /*body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
          return SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  tabBox(),
                  SizedBox(
                    height: 10.h,
                  ),
                  matchListBox(controller.tabs),
                  SizedBox(
                    height: 15.h,
                  ),
                  matchesNewBox(controller.liveMatches),
                  bannerBox(controller.featuredPlayer),
                  SizedBox(
                    height: 15.h,
                  ),
                  currentSeriesBox(controller.currentSeries),
                  SizedBox(
                    height: 15.h,
                  ),
                  latestNewsBox(controller.latestNews),
                  SizedBox(
                    height: 15.h,
                  ),
                  adsBlock(),
                  SizedBox(
                    height: 15.h,
                  ),
                  cricBitesStoryBox(controller.cricketStories),
                  SizedBox(
                    height: 15.h,
                  ),
                  // seriesListBox(),
                ],
              ),
            ),
          );
        }
      ),*/
    );
  }

  Future<void> _handleNavigation(String routeName) async {
    final status = await AppPrefs.getLoginStatus();
    if (status == 1) {
      Get.toNamed(routeName);
    } else {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) {
          return CommonAlertPopup(
            title: "You need to login first to continue!",
            onClose: () => Navigator.of(context).pop(),
            onYes: () {
              Navigator.of(context).pop(true);
              Get.offAllNamed(AppRoutes.login);
            },
            onNo: () =>
                Navigator.of(context).pop(false),
            yesChild: Text("Login",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp)),
            noChild: Text("No",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp)),
          );
        },
      );
    }
  }

  List<String> itemsList = ["Live", "Series", "News", "Schedule",];
  List<String> matchesList = [
    "All Matches",
    "ENG vs IND",
    "SL vs BAN",
    "The Hundred women 2025"
  ];
  int selectedIndex = 0;
  final List<MatchModel> matches = [
    MatchModel(
      image:
          "https://images.hindustantimes.com/rf/image_size_960x540/HT/p2/2019/09/24/Pictures/file-photo-pakistan-cricket-world-cup-india_baa3875a-de87-11e9-93be-d8edb8f85faf.jpg",
      seriesName: "IPL 2025",
      teamA: "MI",
      scoreA: "180/6",
      teamB: "CSK",
      scoreB: "175/8",
      status: "Winner: MI by 5 runs",
      oversA: "10.5",
      oversB: "00",
      result: "India won the match by 10 wickets",
      teamAFlag:
          "https://5.imimg.com/data5/SELLER/Default/2022/8/XD/RG/VE/3917006/indian-flag-500x500-500x500.jpg",
      teamBFlag:
          "https://i.pinimg.com/474x/2f/e3/96/2fe39670bc6a6246fc131a22b1cad28e.jpg",
    ),
    MatchModel(
      image:
          "https://d16f573ilcot6q.cloudfront.net/wp-content/uploads/2024/08/team-india-4-1.webp",
      seriesName: "World Cup 2025",
      teamA: "IND",
      scoreA: "250/7",
      teamB: "AUS",
      scoreB: "248/9",
      status: "Winner: IND by 1 wicket",
      oversA: "10.5",
      oversB: "00",
      result: "India won the match by 10 wickets",
      teamAFlag:
          "https://5.imimg.com/data5/SELLER/Default/2022/8/XD/RG/VE/3917006/indian-flag-500x500-500x500.jpg",
      teamBFlag:
          "https://i.pinimg.com/474x/2f/e3/96/2fe39670bc6a6246fc131a22b1cad28e.jpg",
    ),
    MatchModel(
      image:
          "https://currentaffairs.adda247.com/wp-content/uploads/multisite/sites/5/2023/08/02144310/all-Indian-cricketer-name.jpg",
      seriesName: "World Cup 2025",
      teamA: "IND",
      scoreA: "250/7",
      teamB: "AUS",
      scoreB: "248/9",
      status: "Winner: IND by 1 wicket",
      oversA: "10.5",
      oversB: "00",
      result: "India won the match by 10 wickets",
      teamAFlag:
          "https://5.imimg.com/data5/SELLER/Default/2022/8/XD/RG/VE/3917006/indian-flag-500x500-500x500.jpg",
      teamBFlag:
          "https://i.pinimg.com/474x/2f/e3/96/2fe39670bc6a6246fc131a22b1cad28e.jpg",
    ),
  ];

  tabBox() {
    return Container(
      height: 35.h,
      decoration: BoxDecoration(
        border: const Border(
          top: BorderSide(
            color: AppColors.textFieldBorder,
          ),
          bottom: BorderSide(
            color: AppColors.textFieldBorder,
          ),
        ),
        color: AppColors.primaryColor.withOpacity(0.4),
      ),
      child: ListView.separated(
          separatorBuilder: (_, __) {
            return SizedBox(
              width: 20.w,
            );
          },
          itemCount: itemsList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Row(
              children: [
                index == 0
                    ? Lottie.asset(AppImages.liveJson)
                    : const SizedBox(),
                Text(
                  itemsList[index],
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          }),
    );
  }

  matchListBox(RxList<MatchFilter> tabs) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
          separatorBuilder: (_, __) {
            return SizedBox(
              width: 10.w,
            );
          },
          itemCount: tabs.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 05.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35.r),
                  border: Border.all(
                    color: AppColors.textFieldBorder,
                  ),
                  gradient: selectedIndex == index
                      ? const LinearGradient(
                          colors: [
                            AppColors.buttonTop,
                            AppColors.buttonBottom,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                      : const LinearGradient(colors: [
                          AppColors.transparent,
                          AppColors.transparent,
                        ]),
                ),
                child: Text(
                  tabs[index].name!,
                  style: TextStyle(
                    color: selectedIndex == index
                        ? AppColors.black
                        : AppColors.white,
                    fontSize: 14.sp,
                    fontWeight: selectedIndex == index
                        ? FontWeight.w700
                        : FontWeight.w500,
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget matchesBox() {
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: false,
        autoPlay: false,
        viewportFraction: 0.9,
        initialPage: 0,
        reverse: false,
        enableInfiniteScroll: false,
      ),
      items: matches.map((match) {
        return Builder(
          builder: (context) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2C), // dark bg like screenshot
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner image with status badge
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
                        child: Image.network(
                          match.image,
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 3,
                        left: 3,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            match.status, // Completed, Live, Upcoming
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Match info box
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Series name
                          Text(
                            match.seriesName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),

                          // Team A
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundImage:
                                        NetworkImage(match.teamAFlag),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    match.teamA,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ],
                              ),
                              Text(
                                "(${match.oversA}) ${match.scoreA}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),

                          // Team B
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundImage:
                                        NetworkImage(match.teamBFlag),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    match.teamB,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ],
                              ),
                              Text(
                                "(${match.oversB}) ${match.scoreB}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                          const Spacer(),

                          // Match result
                          Text(
                            match.result,
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget matchesNewBox(RxList<LiveMatch> liveMatches) {
    return SizedBox(
      height: 300, // Pure list ki height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: liveMatches.length,
        itemBuilder: (context, index) {
          final match = liveMatches[index];
          return Container(
            width: 350,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E2C),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner image with status badge
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        match.teams!.teamA!.flag!,
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            'https://currentaffairs.adda247.com/wp-content/uploads/multisite/sites/5/2023/08/02144310/all-Indian-cricketer-name.jpg',
                            height: 140,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 3,
                      left: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          match.status!,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Match info box
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Series name
                      Text(
                        match.tournament!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // Team A
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(match.teams!.teamA!.flag!),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                match.teams!.teamA!.name!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                          Text(
                            "(${match.teams!.teamA!.overs}) ${match.teams!.teamA!.overs}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Team B
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(match.teams!.teamB!.flag!),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                match.teams!.teamB!.name!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                          Text(
                            "(${match.teams!.teamB!.overs!}) ${match.teams!.teamB!.overs!}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Match result
                      Text(
                        match.result!,
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
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
    );
  }

  Widget bannerBox(Rx<FeaturedPlayer> featuredPlayer) {
    return Container(
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: Image.network(
          featuredPlayer.value.image ??
              "https://i.pinimg.com/736x/36/ba/ed/36baede9f38235e274f144ec31381f9b.jpg",
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return Image.network(
              'https://i.pinimg.com/736x/36/ba/ed/36baede9f38235e274f144ec31381f9b.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
            );
          },
        ),
      ),
    );
  }


  currentSeriesBox(RxList<CurrentSery> currentSeries) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Current Series",
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.white,
            ),
          ],
        ),
        Divider(
          color: AppColors.primaryColor,
          indent: 10.w,
          endIndent: 10.w,
        ),
        SizedBox(
          height: 06.h,
        ),
        SizedBox(
          height: 200.h,
          child: ListView.separated(
              separatorBuilder: (_, __) {
                return SizedBox(
                  width: 14.w,
                );
              },
              itemCount: currentSeries.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  height: 200.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13.r),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(13.r),
                      child: Image.network(
                        currentSeries[index].image??"",
                        fit: BoxFit.fill,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            'https://images1.dnaindia.com/images/DNA-EN/900x1600/2023/9/26/1695748290240_desktopwallpaperdhonimsdhoniindia.jpg', // 👈 Local fallback image
                            fit: BoxFit.fill,
                            width: double.infinity,
                          );
                        },
                      ),
                  ),
                );
              }),
        )
      ],
    );
  }

  latestNewsBox(RxList<CricketStory> latestNews) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Latest News",
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.white,
            ),
          ],
        ),
        Divider(
          color: AppColors.primaryColor,
          indent: 10.w,
          endIndent: 10.w,
        ),
        SizedBox(
          height: 06.h,
        ),
        SizedBox(
          height: 320.h,
          child: ListView.separated(
            separatorBuilder: (_, __) => SizedBox(width: 14.w),
            itemCount: latestNews.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final newsItem = latestNews[index];
              final DateTime publishedAt = newsItem.publishedAt ?? DateTime.now();

              final formattedDate = DateFormat('dd MMM yyyy').format(publishedAt);
              // final formattedTime = DateFormat('hh:mm a').format(publishedAt);
              // final relativeTime = timeago.format(publishedAt, allowFromNow: false);
              return Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.primaryColor,
                ),
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.network(
                          newsItem.image ??
                              "",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              'https://www.fii.org.in/wp-content/uploads/2020/09/MS-Dhoni-announced-his-retirement-from-international-cricket.jpg', // 🔁 Provide a local asset as fallback
                              fit: BoxFit.cover,
                              width: double.infinity,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      newsItem.title ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined, color: AppColors.white),
                        SizedBox(width: 8.w),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 15.w),
                        const Icon(Icons.access_time, color: AppColors.white),
                        SizedBox(width: 8.w),
                        Text(
                          newsItem.readTime ?? "2 min",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget adsBlock() {
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

  cricBitesStoryBox(RxList<CricketStory> cricketStories) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Get.toNamed(AppRoutes.story);
          },
          child: Row(
            children: [
              Text(
                "Cricbites Stories",
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.white,
              ),
            ],
          ),
        ),
        Divider(
          color: AppColors.primaryColor,
          indent: 10.w,
          endIndent: 10.w,
        ),
        SizedBox(
          height: 06.h,
        ),
        SizedBox(
          height: 260.h,
          child: ListView.separated(
              separatorBuilder: (_, __) {
                return SizedBox(
                  width: 14.w,
                );
              },
              itemCount: cricketStories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                String? imageUrl = cricketStories[index].image;
                String finalUrl = (imageUrl != null && imageUrl.isNotEmpty)
                    ? imageUrl
                    : "https://images1.dnaindia.com/images/DNA-EN/900x1600/2023/9/26/1695748290240_desktopwallpaperdhonimsdhoniindia.jpg";
                return Container(
                  height: 260.h,
                  width: 200.w,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13.r),
                    border: Border.all(color: AppColors.textFieldBorder,),
                    image:  DecorationImage(image:  NetworkImage(finalUrl),
                      fit: BoxFit.cover,),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.5),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(13.r),),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(13.r),),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Text(
                            cricketStories[index].title!,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }

  seriesListBox(){
    return ListView(
      children: [
        buildSeriesSection(
          seriesTitle: "India Tour Of England",
          team1: "ENG",
          team2: "IND",
          matchTitle: "4th Test, Manchester",
          matchDate: "2 Jul 2025, Wed, 3:30 PM IST",
          horizontalMatches: [
            {
              "title": "PAK WOMEN VS IRE WOMEN",
              "subtitle": "1st T20I, Full Scorecard",
              "date": "27 JUN 2025",
              "duration": "2 min",
              "badge": "1st T20, Full Scorecard",
              "image": "assets/images/match_bg1.png",
            },
            {
              "title": "INDIA UPCOMING CRICKET MATCH",
              "subtitle": "Points Table, Schedule",
              "date": "28 JUN 2025",
              "duration": "",
              "badge": "Schedule",
              "image": "assets/images/match_bg2.png",
            },
          ],
        ),
        buildSeriesSection(
          seriesTitle: "South Africa Tour Of India",
          team1: "ENG",
          team2: "IND",
          matchTitle: "4th Test, Manchester",
          matchDate: "2 Jul 2025, Wed, 3:30 PM IST",
          horizontalMatches: [
            {
              "title": "PAK WOMEN VS IRE WOMEN",
              "subtitle": "1st T20I, Full Scorecard",
              "date": "27 JUN 2025",
              "duration": "2 min",
              "badge": "1st T20",
              "image": "assets/images/match_bg1.png",
            }
          ],
        ),
      ],
    );
  }

  Widget buildSeriesSection({
    required String seriesTitle,
    required String team1,
    required String team2,
    required String matchTitle,
    required String matchDate,
    required List<Map<String, String>> horizontalMatches,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Series Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                seriesTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
            ],
          ),
          Divider(color: Colors.white24),

          SizedBox(height: 10),

          // Tabs
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSeriesTab("Fixture", true),
              _buildSeriesTab("Stats", false),
              _buildSeriesTab("Squad", false),
            ],
          ),

          SizedBox(height: 10),

          // Upcoming Match Card
          _buildUpcomingMatchCard(
            team1: team1,
            team2: team2,
            matchTitle: matchTitle,
            matchDate: matchDate,
          ),

          SizedBox(height: 15),

          // Horizontal Matches List
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: horizontalMatches.length,
              separatorBuilder: (_, __) => SizedBox(width: 12),
              itemBuilder: (context, index) {
                final match = horizontalMatches[index];
                return _buildSeriesMatchCard(
                  title: match["title"] ?? "",
                  subtitle: match["subtitle"] ?? "",
                  date: match["date"] ?? "",
                  duration: match["duration"] ?? "",
                  badge: match["badge"] ?? "",
                  image: match["image"] ?? "",
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Tabs widget
  Widget _buildSeriesTab(String title, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white24 : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// 🔹 Upcoming Match Card
  Widget _buildUpcomingMatchCard({
    required String team1,
    required String team2,
    required String matchTitle,
    required String matchDate,
  }) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Upcoming Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text("Upcoming",
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
          SizedBox(height: 10),

          // Teams Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(team1,
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              Column(
                children: [
                  Text(matchTitle,
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                  SizedBox(height: 3),
                  Text(matchDate,
                      style: TextStyle(color: Colors.white70, fontSize: 11)),
                ],
              ),
              Text(team2,
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔹 Match Card for Horizontal List
  Widget _buildSeriesMatchCard({
    required String title,
    required String subtitle,
    required String date,
    required String duration,
    required String badge,
    required String image,
  }) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(image, height: 100, width: 200, fit: BoxFit.cover),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (badge.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      badge,
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                SizedBox(height: 5),
                Text(title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
                SizedBox(height: 4),
                Text(subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14, color: Colors.white54),
                    SizedBox(width: 5),
                    Text(date,
                        style: TextStyle(color: Colors.white54, fontSize: 11)),
                    if (duration.isNotEmpty) ...[
                      SizedBox(width: 10),
                      Icon(Icons.access_time, size: 14, color: Colors.white54),
                      SizedBox(width: 5),
                      Text(duration,
                          style: TextStyle(color: Colors.white54, fontSize: 11)),
                    ]
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

class MatchModel {
  final String image;
  final String seriesName;
  final String teamA;
  final String scoreA;
  final String teamB;
  final String scoreB;
  final String status;
  final String teamAFlag;
  final String teamBFlag;
  final String oversA;
  final String oversB;
  final String result;

  MatchModel({
    required this.image,
    required this.seriesName,
    required this.teamA,
    required this.scoreA,
    required this.teamB,
    required this.scoreB,
    required this.status,
    required this.teamAFlag,
    required this.teamBFlag,
    required this.oversA,
    required this.oversB,
    required this.result,
  });
}
