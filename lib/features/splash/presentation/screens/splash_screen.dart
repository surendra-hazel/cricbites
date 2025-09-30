import 'package:Cricbites/core/constants/app_images.dart';
import 'package:Cricbites/core/constants/app_prefs.dart';
import 'package:Cricbites/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _checkLogin();
    });
  }

  Future<void> _checkLogin() async {
    await Future.delayed(const Duration(seconds: 2)); // splash delay

    final int isLoggedIn = await AppPrefs.getLoginStatus()??2;

    if (isLoggedIn!=2) {
      Get.offAllNamed(AppRoutes.bottomNavigation);
      // Get.offAllNamed(AppRoutes.setProfile);
    } else {
      Get.offAllNamed(AppRoutes.login);
      // Get.offAllNamed(AppRoutes.bottomNavigation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppImages.splash,
            ),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
