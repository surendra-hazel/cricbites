import 'dart:io';
import 'package:Cricbites/core/constants/app_prefs.dart';
import 'package:Cricbites/features/set_profile/presentation/controllers/set_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AvatarPicker extends StatelessWidget {
  final bool showEditIcon;
  const AvatarPicker({super.key, required this.showEditIcon});

  Future<void> _pickImage(
      BuildContext context, ImageSource source, SetProfileController controller) async {
    PermissionStatus status;

    if (source == ImageSource.camera) {
      status = await Permission.camera.request();
    } else {
      status = Platform.isIOS
          ? await Permission.storage.request()
          : await Permission.photos.request();
    }

    if (status.isGranted) {
      await controller.pickImage(source);
      if (context.mounted) Navigator.pop(context);
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Permission denied")),
        );
      }
    }
  }

  void _showPickerSheet(BuildContext context, SetProfileController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E2A3A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.white),
                title: const Text("Camera", style: TextStyle(color: Colors.white)),
                onTap: () => _pickImage(context, ImageSource.camera, controller),
              ),
              ListTile(
                leading: const Icon(Icons.photo, color: Colors.white),
                title: const Text("Gallery", style: TextStyle(color: Colors.white)),
                onTap: () => _pickImage(context, ImageSource.gallery, controller),
              ),
              ListTile(
                leading: const Icon(Icons.close, color: Colors.red),
                title: const Text("Close", style: TextStyle(color: Colors.red)),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SetProfileController>();

    return Center(
      child: FutureBuilder<String?>(
        future: AppPrefs.getUserImage(),
        builder: (context, snapshot) {
          String? savedImage = snapshot.data;

          return Obx(() {
            String currentImage = controller.profileImage.value.isNotEmpty
                ? controller.profileImage.value
                : (savedImage ?? "");
            return Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey.shade800,
                  backgroundImage: (currentImage.isNotEmpty)
                      ? NetworkImage(currentImage)
                      : null,
                  child: (currentImage.isEmpty)
                      ? const Icon(Icons.person, size: 60, color: Colors.white70)
                      : null,
                ),
                showEditIcon?Positioned(
                  bottom: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => _showPickerSheet(context, controller),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ):const SizedBox(),
              ],
            );
          });
        },
      ),
    );
  }
}
