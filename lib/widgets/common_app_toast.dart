import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppToast {
  static void showSuccess(String message) {
    Get.snackbar(
      "Success",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
    );
  }

  static void showError(String message) {
    Get.snackbar(
      "Warning",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
    );
  }

  static void showInfo(String message) {
    Get.snackbar(
      "Info",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class AppToast {
//   static void showSuccess(String message) {
//     final messenger = ScaffoldMessenger.of(Get.context!);
//     messenger.clearSnackBars();
//     messenger.showSnackBar(
//       SnackBar(
//         content: Text(message, style: const TextStyle(color: Colors.white)),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }
//
//   static void showError(String message) {
//     final messenger = ScaffoldMessenger.of(Get.context!);
//     messenger.clearSnackBars();
//     messenger.showSnackBar(
//       SnackBar(
//         content: Text(message, style: const TextStyle(color: Colors.white)),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }
//
//   static void showInfo(String message) {
//     final messenger = ScaffoldMessenger.of(Get.context!);
//     messenger.clearSnackBars();
//     messenger.showSnackBar(
//       SnackBar(
//         content: Text(message, style: const TextStyle(color: Colors.white)),
//         backgroundColor: Colors.blue,
//       ),
//     );
//   }
// }
