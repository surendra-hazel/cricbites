import 'package:Cricbites/core/constants/app_prefs.dart';
import 'package:Cricbites/data/api_service/api_service.dart';
import 'package:Cricbites/widgets/common_app_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChannelDetails {
  final typeController = TextEditingController();
  final nameController = TextEditingController();
  final urlController = TextEditingController();
}

class PromoteAppController extends GetxController {
  // Basic details
  final ApiService _apiService = ApiService();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  var isLoading = false.obs;
  RxList<ChannelDetails> channels = <ChannelDetails>[].obs;
  RxList<ChannelDetailModel> savedChannels = <ChannelDetailModel>[].obs;

  void addChannel() {
    channels.add(ChannelDetails());
  }

  void removeChannel(int index) {
    if (index < channels.length) {
      channels.removeAt(index);
    }
    if (index < savedChannels.length) {
      savedChannels.removeAt(index);
    }
  }

  void saveChannel(int index) {
    if (index >= channels.length) return;

    final channel = channels[index];

    if (channel.typeController.text.trim().isEmpty) {
      AppToast.showError("Please enter channel type");
      return;
    }
    if (channel.nameController.text.trim().isEmpty) {
      AppToast.showError("Please enter channel name");
      return;
    }
    if (channel.urlController.text.trim().isEmpty) {
      AppToast.showError("Please enter channel URL");
      return;
    }
    if (!GetUtils.isURL(channel.urlController.text.trim())) {
      AppToast.showError("Please enter valid channel URL");
      return;
    }

    // final urlText = channel.urlController.text.trim();
    // final uri = Uri.tryParse(urlText);
    //
    // if (uri == null || !uri.isAbsolute ||
    //     (uri.scheme != "http" && uri.scheme != "https")) {
    //   AppToast.showError("Please enter a valid channel URL");
    //   return;
    // }

    final model = ChannelDetailModel(
      type: channel.typeController.text.trim(),
      name: channel.nameController.text.trim(),
      url: channel.urlController.text.trim(),
    );

    if (index < savedChannels.length) {
      savedChannels[index] = model;
    } else {
      savedChannels.add(model);
    }

    debugPrint("✅ Channel ${index + 1} Saved: ${model.toJson()}");
    AppToast.showSuccess("Channel ${index + 1} saved successfully!");
  }

  Future<void> submitDetails() async {
    if (nameController.text.trim().isEmpty) {
      AppToast.showError("Please enter your full name");
      return;
    }
    if (emailController.text.trim().isEmpty) {
      AppToast.showError("Please enter your email address");
      return;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      AppToast.showError("Please enter a valid email address");
      return;
    }
    if (mobileController.text.trim().isEmpty) {
      AppToast.showError("Please enter your mobile number");
      return;
    }
    if (mobileController.text.trim().length < 10) {
      AppToast.showError("Mobile number must be 10 digits");
      return;
    }
    if (cityController.text.trim().isEmpty) {
      AppToast.showError("Please enter your city");
      return;
    }
    if (stateController.text.trim().isEmpty) {
      AppToast.showError("Please enter your state");
      return;
    }

    if (savedChannels.isEmpty) {
      AppToast.showError("Please save at least one channel before submitting");
      return;
    }
    final userId = await AppPrefs.getUserId();
    final data = {
      "user_id": userId,
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "mobile": mobileController.text.trim(),
      "city": cityController.text.trim(),
      "state": stateController.text.trim(),
      "channel_details": savedChannels.map((e) => e.toJson()).toList(),
    };

    try {
      isLoading.value = true;

      final response = await _apiService.addPromoteAppMethod(body: data);
      if (response.status == 1) {
        Get.back(result: true);
        AppToast.showSuccess(response.message ?? "");
      } else {
        AppToast.showError(response.message ?? "Failed to update");
      }
    } catch (e) {
      AppToast.showError("Something went wrong. Please try again!");
    } finally {
      isLoading.value = false;
    }
  }



  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    cityController.dispose();
    stateController.dispose();

    for (var channel in channels) {
      channel.typeController.dispose();
      channel.nameController.dispose();
      channel.urlController.dispose();
    }
    super.onClose();
  }
}



class ChannelDetailModel {
  String? name;
  String? url;
  String? type;

  ChannelDetailModel({this.name, this.url, this.type});

  factory ChannelDetailModel.fromJson(Map<String, dynamic> json) {
    return ChannelDetailModel(
      name: json['name'] as String?,
      url: json['url'] as String?,
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'type': type,
    };
  }
}