class AppConstants {
  // API Configuration
  static const String baseUrl = "https://api.cricbites.com/";
  static const String baseWebviewUrl = "https://www.cricbites.com/";
  static const int timeoutDuration = 30;

  // Validation
  static const int phoneNumberLength = 10;
  static const int otpLength = 6;
  static const int minAge = 18;

  // Animation Duration
  static const int splashDuration = 3;
  static const int animationDuration = 300;

  // Storage Keys
  static const String isFirstTime = 'is_first_time';
  static const String userToken = 'user_token';
  static const String userProfile = 'user_profile';
  static const String themeMode = 'theme_mode';

  // Social Login
  static const String googleClientId = 'your_google_client_id';
  static const String facebookAppId = 'your_facebook_app_id';

  static const String registerUrl = '${baseUrl}api/register_new';
  static const String loginVerifyOtp = '${baseUrl}api/login_verify_otp';
  static const String verifyRegisterMobileOtp =
      '${baseUrl}api/register_mobile_otp';
  static const String emailRegister = '${baseUrl}api/auth/edit-email';
  static const String registerEmailOtp = '${baseUrl}api/auth/verify_email_otp';
  static const String updateTeamNameUrl = '${baseUrl}api/updateteamname';
  static const String updateProfileImage = '${baseUrl}api/update-profile-image';
  static const String getUserProfile = '${baseUrl}api/user-full-details';
  static const String editUserProfile = '${baseUrl}api/edit-profile';
  static const String logout = '${baseUrl}api/logout_web';
  static const String referList = '${baseUrl}api/refer-bonus-list-new';
  static const String addPromoteApp = '${baseUrl}api/addPromoteBasicDetails';
  static const String feedback = '${baseUrl}api/feedback';
  static const String scheduleList = '${baseUrl}api/get-match-schedule';
  static const String rankList = '${baseUrl}api/get-cricket-ranking';
  static const String seriesList = '${baseUrl}api/get-all-competitions';
  static const String quizList = '${baseUrl}api/quiz-list';
  static const String quizSubmit = '${baseUrl}api/quiz_join';
  static const String pollList = '${baseUrl}api/poll-list';
  static const String pollVote = '${baseUrl}api/poll-vote';
}
