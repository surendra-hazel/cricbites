  import 'dart:convert';

  import 'package:Cricbites/core/constants/app_colors.dart';
  import 'package:Cricbites/core/constants/app_constants.dart';
  import 'package:Cricbites/core/routes/app_routes.dart';
  import 'package:Cricbites/features/schedule/data/schedule_list_modal.dart';
  import 'package:Cricbites/features/schedule/presentation/controller/schedule_controller.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:get/get.dart';
  import 'package:intl/intl.dart';

  class ScheduleScreen extends StatefulWidget {
    const ScheduleScreen({super.key});

    @override
    State<ScheduleScreen> createState() => _ScheduleScreenState();
  }

  class _ScheduleScreenState extends State<ScheduleScreen> {
    final ScheduleController controller = Get.put(ScheduleController());

    String? selectedTab = "live";
    int? selectedFilter = 0;

    final List<String> topTabs = ["Live", "Upcoming", "Result"];
    final List<String> topTabsNavigate = ["live", "upcomming", "completed"];

    @override
    void initState() {
      super.initState();
      controller.fetchSchedule(matchStatus: "live");
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: const Color(0xFF0D1221),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D1221),
          elevation: 0,
          title: const Text(
            "Schedule",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// --- Top Tabs (Live | Upcoming | Results)
            const Divider(color: AppColors.textFieldBorder),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(topTabs.length, (index) {
                    final isSelected =
                        topTabs[index].toLowerCase() == selectedTab;
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          setState(
                              () => selectedTab = topTabs[index].toLowerCase());
                          controller.fetchSchedule(
                              matchStatus: topTabsNavigate[index].toLowerCase(),
                              competitionId: "0");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 8),
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
                                  ),
                            border: Border.all(color: Colors.grey.shade600),
                          ),
                          child: Text(
                            topTabs[index],
                            style: TextStyle(
                              color: isSelected ? AppColors.white : Colors.white,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            /// --- Filter Tabs (Heading list from API)
            Container(
              height: 40,
              color: AppColors.bodyTop,
              child: Obx(() {
                if (controller.headings.isEmpty) {
                  return const SizedBox();
                }
                return ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  children: controller.headings.map((filter) {
                    final isSelected = filter.compId == selectedFilter;
                    return GestureDetector(
                      onTap: () {
                        setState(() => selectedFilter = filter.compId!);
                        controller.fetchSchedule(
                          matchStatus: selectedTab,
                          competitionId: selectedFilter!.toString(),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        child: Text(
                          filter.compName!,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppColors.white.withOpacity(0.5),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
            ),

            /// --- Match List (API data)
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.white),
                  );
                }

                if (controller.matches.isEmpty) {
                  return const Center(
                    child:
                        Text("No matches", style: TextStyle(color: Colors.white)),
                  );
                }

                return ListView.separated(
                  separatorBuilder: (_, __) => Divider(
                    color: AppColors.black.withOpacity(0.7),
                    height: 20.h,
                  ),
                  itemCount: controller.matches.length,
                  itemBuilder: (context, index) {
                    final match = controller.matches[index];
                    return GestureDetector(
                      onTap: () {
                        final String url = buildMatchUrl(
                            tournament: match.tournament!,
                            matchId: match.matchId!);
                        Get.toNamed(
                          AppRoutes.webView,
                          arguments: url,
                        );
                      },
                      child: _matchCard(match
                          // title: match.compName ?? "Unknown",
                          // team1: match.team1?.name ?? "",
                          // team2: match.team2?.name ?? "",
                          // flag1: match.team1?.logoUrl ?? "",
                          // flag2: match.team2?.logoUrl ?? "",
                          // status: match.status ?? "",
                          // date: formatMatchDate(match.startDate!),
                          ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      );
    }

    String formatMatchDate(DateTime? date) {
      if (date == null) return "";
      try {
        final formatter = DateFormat("MMM d, hh:mm a");
        return formatter.format(date);
      } catch (e) {
        return "";
      }
    }

    static String buildMatchUrl({
      required String tournament,
      required int matchId,
    }) {
      const tabSlug = "live-scores";
      final matchSlug = tournament.toLowerCase().replaceAll(" ", "_");
      final encodedMatchId = base64.encode(utf8.encode(matchId.toString()));
      return "${AppConstants.baseWebviewUrl}$tabSlug/$matchSlug/$encodedMatchId/?app=1";
    }

    Widget _matchCard(ScheduleList match) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.white.withOpacity(0.4))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              match.compName ?? "",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),

            /// Teams
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _teamRow(
                      match.team1?.name ?? "", match.team1?.logoUrl ?? ""),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  match.status == "Live" || match.status == "Completed"
                      ? match.team1?.scoresFull ?? "Yet To bat"
                      : match.status!,
                  style: TextStyle(color: AppColors.white, fontSize: 12.sp),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _teamRow(
                      match.team2?.name ?? "", match.team2?.logoUrl ?? ""),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  match.status == "Live" || match.status == "Completed"
                      ? match.team2?.scoresFull ?? "Yet To bat"
                      : match.status!,
                  style: TextStyle(color: AppColors.white, fontSize: 12.sp),
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// Match Time
            Text(
              match.status == "Live" || match.status == "Completed"
                  ? match.statusNote!
                  : formatMatchDate(match.startDate!),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: match.status == "Live"
                    ? AppColors.red
                    : match.status == "Completed"
                        ? AppColors.green
                        : AppColors.buttonTop,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    Widget _teamRow(String team, String flag) {
      return Row(
        children: [
          ClipOval(
            child: Image.network(
              flag,
              height: 30,
              width: 30,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.flag, size: 20, color: Colors.white);
              },
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              team,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      );
    }
  }