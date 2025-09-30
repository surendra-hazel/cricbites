import 'package:get/get.dart';

class PreferenceController extends GetxController {
  // Data Saver Options
  var autoDataRefresh = false.obs;
  var loadImages = false.obs;
  var lowQualityVideo = false.obs;

  // Notifications
  var allowNotifications = false.obs;
  var sound = false.obs;
  var vibration = false.obs;

  // Haptic Feedback
  var hapticVibration = false.obs;

  // Do Not Disturb
  var doNotDisturb = false.obs;
  var fromTime = "23:00".obs;
  var toTime = "07:00".obs;

  // Primary Notifications
  var recommendedStories = true.obs;
  var breakingNews = true.obs;
  var deals = true.obs;
  var videoAlerts = true.obs;

  // Save/Load preferences from storage if needed
  @override
  void onInit() {
    super.onInit();
    // TODO: Load saved preferences from local storage if required
  }
}
