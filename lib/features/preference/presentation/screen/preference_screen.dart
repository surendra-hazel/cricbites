import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/features/preference/presentation/controller/preference_controller.dart';
import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PreferenceScreen extends StatelessWidget {
  const PreferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PreferenceController());

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CommonAppBar(
        titleText: "Preference",
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Data Saver Options"),
            _buildSwitchTile(
              "Automatic Data Refresh",
              "Manual refresh is still available",
              controller.autoDataRefresh,
            ),
            _buildSwitchTile(
              "Load Images",
              "Effects data usage",
              controller.loadImages,
            ),
            _buildSwitchTile(
              "Low Quality Video Playback",
              "Save data on video streaming",
              controller.lowQualityVideo,
            ),

            SizedBox(height: 16.h),
            _sectionTitle("Notifications"),
            _buildSwitchTile("Allow Notifications", "", controller.allowNotifications),
            _buildSwitchTile("Sound", "", controller.sound),
            _buildSwitchTile("Vibration", "", controller.vibration),

            SizedBox(height: 16.h),
            _sectionTitle("Haptic Feedback"),
            _buildSwitchTile("Vibration", "", controller.hapticVibration),

            SizedBox(height: 16.h),
            _sectionTitle("Do not Disturb"),
            _buildSwitchTile(
              "Do not disturb",
              "Notification will not make sound or vibrate",
              controller.doNotDisturb,
            ),
            _timeRange("From", controller.fromTime),
            _timeRange("To", controller.toTime),

            SizedBox(height: 16.h),
            _sectionTitle("Primary notifications"),
            _buildCheckTile("Recommended Stories", "Notify about interesting/useful stories", controller.recommendedStories),
            _buildCheckTile("Breaking News", "Notify about all the breaking news happening inside the cricketing world", controller.breakingNews),
            _buildCheckTile("Deals", "Notify about deals for Cricbites Plus Users", controller.deals),
            _buildCheckTile("Video Alerts", "Notify about recommended videos", controller.videoAlerts),

            SizedBox(height: 16.h),
            _sectionTitle("Opt-In Notifications"),
            _simpleTile("Matches"),
            _simpleTile("Series"),
            _simpleTile("Teams"),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Widget _buildSwitchTile(String title, String subtitle, RxBool value) {
  //   return Obx(
  //         () => Transform.scale(
  //       scale: 0.85,
  //       child: SwitchListTile(
  //         contentPadding: EdgeInsets.zero,
  //         value: value.value,
  //         onChanged: (v) => value.value = v,
  //         activeColor: AppColors.primaryColor,
  //         activeTrackColor: AppColors.white,
  //         title: Text(title, style: const TextStyle(color: Colors.white)),
  //         subtitle: subtitle.isNotEmpty
  //             ? Text(subtitle, style: const TextStyle(color: Colors.white70))
  //             : null,
  //         controlAffinity: ListTileControlAffinity.trailing,
  //       ),
  //     ),
  //   );
  // }


  Widget _buildSwitchTile(String title, String subtitle, RxBool value) {
    return Obx(
          () => ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: subtitle.isNotEmpty
            ? Text(subtitle, style: const TextStyle(color: Colors.white70))
            : null,
        trailing: Transform.scale(
          scale: 0.85,
          child: Switch(
            value: value.value,
            onChanged: (v) => value.value = v,
            activeColor: AppColors.primaryColor,
            activeTrackColor: AppColors.white,
          ),
        ),
      ),
    );
  }


  Widget _buildCheckTile(String title, String subtitle, RxBool value) {
    return Obx(
          () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 16)),
                  if (subtitle.isNotEmpty)
                    Text(subtitle,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Transform.scale(
              scale: 0.9,
              child: Checkbox(
                value: value.value,
                onChanged: (v) => value.value = v ?? false,
                activeColor: AppColors.white,
                checkColor: AppColors.black,
                side:  BorderSide(
                  color: AppColors.white.withOpacity(0.4),
                  width: 2,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _timeRange(String label, RxString time) {
    return Obx(
          () => ListTile(
        title: Text(
          "$label: ${time.value}",
          style: const TextStyle(color: Colors.white),
        ),
        trailing: const Icon(Icons.access_time, color: Colors.white70),
        onTap: () async {
          final picked = await showTimePicker(
            context: Get.context!,
            initialTime: TimeOfDay(
              hour: int.parse(time.value.split(":")[0]),
              minute: int.parse(time.value.split(":")[1]),
            ),
          );
          if (picked != null) {
            time.value =
            "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
          }
        },
      ),
    );
  }

  Widget _simpleTile(String title) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white70),
      onTap: () {

      },
    );
  }
}
