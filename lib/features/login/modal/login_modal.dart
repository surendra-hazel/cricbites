// To parse this JSON data, do
//
//     final loginModal = loginModalFromJson(jsonString);

import 'dart:convert';

LoginModal loginModalFromJson(String str) => LoginModal.fromJson(json.decode(str));

String loginModalToJson(LoginModal data) => json.encode(data.toJson());

class LoginModal {
  int? status;
  String? message;
  int? isLogin;
  int? isRegistered;

  LoginModal({
    this.status,
    this.message,
    this.isLogin,
    this.isRegistered,
  });

  factory LoginModal.fromJson(Map<String, dynamic> json) => LoginModal(
    status: json["status"],
    message: json["message"],
    isLogin: json["is_login"],
    isRegistered: json["is_registered"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "is_login": isLogin,
    "is_registered": isRegistered,
  };

  bool get isLoginSuccess => isLogin == 1;
  bool get isRegisterSuccess => isRegistered == 1;
}
