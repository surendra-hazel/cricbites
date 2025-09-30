// To parse this JSON data, do
//
//     final logoutModal = logoutModalFromJson(jsonString);

import 'dart:convert';

LogoutModal logoutModalFromJson(String str) => LogoutModal.fromJson(json.decode(str));

String logoutModalToJson(LogoutModal data) => json.encode(data.toJson());

class LogoutModal {
  int? status;
  String? message;
  String? user;

  LogoutModal({
    this.status,
    this.message,
    this.user,
  });

  factory LogoutModal.fromJson(Map<String, dynamic> json) => LogoutModal(
    status: json["status"],
    message: json["message"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "user": user,
  };
}
