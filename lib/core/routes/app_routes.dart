import 'package:Cricbites/features/all%20category/presentation/screens/all_category_screen.dart';
import 'package:Cricbites/features/all%20videos/presentation/screen/all_video_screen.dart';
import 'package:Cricbites/features/all_player/presentation/screen/all_player_list_screen.dart';
import 'package:Cricbites/features/all_series/presentation/screen/all_series_list_screen.dart';
import 'package:Cricbites/features/bottom_navigation/presentation/screens/bottom_navigation_screen.dart';
import 'package:Cricbites/features/edit_profile/presentation/screens/edit_profile_screen.dart';
import 'package:Cricbites/features/email_verification/presentation/screens/email_verification_screen.dart';
import 'package:Cricbites/features/feedback/presentation/screen/feedback_screen.dart';
import 'package:Cricbites/features/invite_friend/presentation/screen/invite_friend_screen.dart';
import 'package:Cricbites/features/login/presentation/screens/login_screen.dart';
import 'package:Cricbites/features/otp_verification/presentation/modal/data_send.dart';
import 'package:Cricbites/features/otp_verification/presentation/screens/otp_verification_screen.dart';
import 'package:Cricbites/features/poll/presentation/screen/poll_screen.dart';
import 'package:Cricbites/features/preference/presentation/screen/preference_screen.dart';
import 'package:Cricbites/features/profile/presentation/screens/profile_screen.dart';
import 'package:Cricbites/features/promote/presentation/screen/promote_app_screen.dart';
import 'package:Cricbites/features/promote/presentation/screen/promote_detail_screen.dart';
import 'package:Cricbites/features/quiz/presentation/screen/quiz_screen.dart';
import 'package:Cricbites/features/ranking/presentation/screen/ranking_screen.dart';
import 'package:Cricbites/features/refer_list/presentation/screen/refer_list_screen.dart';
import 'package:Cricbites/features/set_profile/presentation/screens/set_profile_screen.dart';
import 'package:Cricbites/features/splash/presentation/screens/splash_screen.dart';
import 'package:Cricbites/features/story/presentation/screen/story_screen.dart';
import 'package:Cricbites/features/teams/presentation/screen/all_team_list_screen.dart';
import 'package:Cricbites/features/transaction/presentation/screen/transaction_screen.dart';
import 'package:Cricbites/widgets/web_view_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String otpVerification = '/otpVerification';
  static const String emailVerification = '/emailVerification';
  static const String setProfile = '/setProfile';
  static const String bottomNavigation = '/bottomNavigation';
  static const String story = '/story';
  static const String ranking = '/ranking';
  static const String allCategory = '/allCategory';
  static const String profile = '/profile';
  static const String editProfile = '/editProfile';
  static const String allVideo = '/allVideo';
  static const String transaction = '/transaction';
  static const String inviteFriend = '/inviteFriend';
  static const String referList = '/referList';
  static const String allSeries = '/allSeries';
  static const String allTeam = '/allTeam';
  static const String allPlayer = '/allPlayer';
  static const String webView = '/webView';
  static const String preference = '/preference';
  static const String feedback = '/feedback';
  static const String promote = '/promote';
  static const String promoteDetail = '/promoteDetails';
  static const String quiz = '/quiz';
  static const String poll = '/poll';

  static final List<GetPage> getPages = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(
        name: otpVerification,
        page: () {
          final userData = Get.arguments as UserData;
          return OtpVerificationScreen(userData: userData);
        }),
    GetPage(name: emailVerification, page: () => EmailVerificationScreen()),
    GetPage(name: setProfile, page: () => SetProfileScreen()),
    GetPage(name: bottomNavigation, page: () => const BottomNavigationScreen()),
    GetPage(name: story, page: () => const StoriesScreen()),
    GetPage(name: ranking, page: () => const RankingScreen()),
    GetPage(name: allCategory, page: () => const AllCategoryScreen()),
    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(name: editProfile, page: () => const EditProfileScreen()),
    GetPage(name: allVideo, page: () => const AllVideosScreen()),
    GetPage(name: transaction, page: () => const TransactionHistoryScreen()),
    GetPage(name: referList, page: () => const ReferListScreen()),
    GetPage(name: allSeries, page: () => const AllSeriesScreen()),
    GetPage(name: allTeam, page: () => const AllTeamsScreen()),
    GetPage(name: allPlayer, page: () => const AllPlayerScreen()),
    GetPage(name: webView, page: () {
      final url = Get.arguments as String;
      debugPrint("*********** $url ***********");
      return WebViewScreen(url: url,key: const ValueKey("newWindow"),);
    }),
    GetPage(name: preference, page: () => const PreferenceScreen()),
    GetPage(name: feedback, page: () => const FeedbackScreen()),
    GetPage(name: promote, page: () => const PromoteAppScreen()),
    GetPage(name: promoteDetail, page: () => const PromoteAppDetailScreen()),
    GetPage(
        name: inviteFriend,
        page: () {
          final referralCode = Get.arguments as String;
          return InviteFriendScreen(referralCode: referralCode);
        }),
    GetPage(name: quiz, page: () => const QuizScreen()),
    GetPage(name: poll, page: () => const PollScreen()),
  ];
}