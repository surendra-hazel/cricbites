import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/core/constants/app_constants.dart';
import 'package:Cricbites/core/constants/app_prefs.dart';
import 'package:Cricbites/core/routes/app_routes.dart';
import 'package:Cricbites/features/more/presentation/controller/more_controller.dart';
import 'package:Cricbites/widgets/common_alert_popup.dart';
import 'package:Cricbites/widgets/common_app_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MoreController());
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "More",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                FutureBuilder<int?>(
                  future: AppPrefs.getLoginStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    }

                    bool isLoggedIn = snapshot.data==1;

                    return isLoggedIn
                        ? const SizedBox()
                        : _buildMenuItem(
                            icon: Icons.person,
                            title: "Sign In / Sign Up",
                            onTap: () {
                              Get.offAllNamed(AppRoutes.login);
                            },
                            isTop: true,
                          );
                  },
                ),
                // _buildMenuItem(
                //   icon: Icons.grid_view_outlined,
                //   title: "All Category",
                //   onTap: () {
                //     Get.toNamed(AppRoutes.allCategory);
                //   },
                // ),
                _buildMenuItem(
                  icon: Icons.emoji_events_outlined,
                  title: "Ranking",
                  onTap: () {
                    Get.toNamed(AppRoutes.ranking);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.group_outlined,
                  title: "Teams",
                  onTap: () {
                    Get.toNamed(AppRoutes.webView,arguments: "${AppConstants.baseWebviewUrl}category/cricket-teams/?app=1");
                  },
                ),
                _buildMenuItem(
                  icon: Icons.person_pin_outlined,
                  title: "Players",
                  onTap: () {
                    Get.toNamed(AppRoutes.webView,arguments: "${AppConstants.baseWebviewUrl}category/cricket-players/?app=1");
                  },
                ),
                _buildMenuItem(
                  icon: Icons.article_outlined,
                  title: "All Series",
                  onTap: () {
                    Get.toNamed(AppRoutes.allSeries);
                  },
                ),
                // _buildMenuItem(
                //   icon: Icons.play_circle_outline,
                //   title: "All Videos",
                //   onTap: () {
                //     Get.toNamed(AppRoutes.allVideo);
                //   },
                // ),
                _buildMenuItem(
                  icon: Icons.newspaper_outlined,
                  title: "News",
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.webView,
                      arguments: "${AppConstants.baseWebviewUrl}category/cricket-news/?app=1",
                    );
                  },
                ),
                FutureBuilder<int?>(
                  future: AppPrefs.getLoginStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    }

                    bool isLoggedIn = (snapshot.data == 1);

                    return isLoggedIn
                        ? _buildMenuItem(
                      icon: Icons.quiz_outlined,
                      title: "Quiz",
                      onTap: () {
                        Get.toNamed(AppRoutes.quiz);
                      },
                    ):const SizedBox();
                  },
                ),
                FutureBuilder<int?>(
                  future: AppPrefs.getLoginStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    }

                    bool isLoggedIn = (snapshot.data == 1);

                    return isLoggedIn
                        ? _buildMenuItem(
                      icon: Icons.poll,
                      title: "Poll",
                      onTap: () {
                        Get.toNamed(AppRoutes.poll);
                      },
                    ):const SizedBox();
                  },
                ),
                // _buildMenuItem(
                //   icon: Icons.archive_outlined,
                //   title: "Archive",
                //   onTap: () {},
                // ),
                _buildMenuItem(
                  icon: Icons.feedback_outlined,
                  title: "Feedback",
                  onTap: () {
                    _handleNavigation(AppRoutes.feedback);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.campaign,
                  title: "Promote App",
                  onTap: () {
                    _handleNavigation(AppRoutes.promote);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.star_border,
                  title: "Rate the app",
                  onTap: () async {
                    final status = await AppPrefs.getLoginStatus();
                    if (status == 1) {
                      controller.rateThisApp();
                    } else {
                      AppToast.showError("Please login first to rate the app");
                    }
                  },
                ),
                // _buildMenuItem(
                //   icon: Icons.settings_outlined,
                //   title: "Preferences",
                //   onTap: () {
                //     Get.toNamed(AppRoutes.preference);
                //   },
                // ),
                _buildMenuItem(
                  icon: Icons.info_outline,
                  title: "About Cricbites",
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.webView,
                      arguments: "${AppConstants.baseWebviewUrl}about-us/?app=1",
                    );
                  },
                ),
                FutureBuilder<int?>(
                  future: AppPrefs.getLoginStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    }

                    bool isLoggedIn = (snapshot.data == 1);

                    return isLoggedIn
                        ? _buildMenuItem(
                            icon: Icons.logout,
                            title: "Logout",
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return CommonAlertPopup(
                                    title: "Are you sure?",
                                    onClose: () => Navigator.of(context).pop(),
                                    onYes: () {
                                      Navigator.of(context).pop(true);
                                      controller.logoutUser();
                                    },
                                    onNo: () =>
                                        Navigator.of(context).pop(false),
                                    yesChild: Text("Logout",
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
                            },
                          )
                        : const SizedBox();
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  alignment: Alignment.center,
                  child: const Text(
                    "V 1.0",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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


  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isTop = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color:
            isTop ? AppColors.white.withOpacity(0.2) : AppColors.primaryColor,
        border: const Border(
          bottom: BorderSide(color: AppColors.black, width: 1.6),
        ),
      ),
      child: ListTile(
        leading: isTop
            ? Card(
                color: AppColors.white.withOpacity(0.7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(06.r)),
                child: Icon(
                  icon,
                  color: AppColors.black,
                ),
              )
            : Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white70),
        onTap: onTap,
      ),
    );
  }
}
