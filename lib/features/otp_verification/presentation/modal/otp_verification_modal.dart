// To parse this JSON data, do
//
//     final otpVerificationModal = otpVerificationModalFromJson(jsonString);

import 'dart:convert';

OtpVerificationModal otpVerificationModalFromJson(String str) => OtpVerificationModal.fromJson(json.decode(str));

String otpVerificationModalToJson(OtpVerificationModal data) => json.encode(data.toJson());

class OtpVerificationModal {
  int? status;
  String? message;
  User? user;
  String? token;

  OtpVerificationModal({
    this.status,
    this.message,
    this.user,
    this.token,
  });

  factory OtpVerificationModal.fromJson(Map<String, dynamic> json) => OtpVerificationModal(
    status: json["status"],
    message: json["message"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "user": user?.toJson(),
    "token": token,
  };
}

class User {
  int? userId;
  String? customUserToken;
  String? fcmToken;
  int? mobile;
  String? refercode;
  String? username;
  dynamic email;
  String? deviceId;
  String? dob;
  String? gender;
  String? address;
  String? city;
  String? pincode;
  int? emailVerify;
  int? mobileVerify;
  int? bankVerify;
  int? panVerify;
  String? team;
  String? userProfileImage;
  String? image;
  String? jwtToken;

  User({
    this.userId,
    this.customUserToken,
    this.fcmToken,
    this.mobile,
    this.refercode,
    this.username,
    this.email,
    this.deviceId,
    this.dob,
    this.gender,
    this.address,
    this.city,
    this.pincode,
    this.emailVerify,
    this.mobileVerify,
    this.bankVerify,
    this.panVerify,
    this.team,
    this.userProfileImage,
    this.image,
    this.jwtToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["user_id"],
    customUserToken: json["custom_user_token"],
    fcmToken: json["fcmToken"],
    mobile: json["mobile"],
    refercode: json["refercode"],
    username: json["username"],
    email: json["email"],
    deviceId: json["device_id"],
    dob: json["dob"],
    gender: json["gender"],
    address: json["address"],
    city: json["city"],
    pincode: json["pincode"],
    emailVerify: json["email_verify"],
    mobileVerify: json["mobile_verify"],
    bankVerify: json["bank_verify"],
    panVerify: json["pan_verify"],
    team: json["team"],
    userProfileImage: json["user_profile_image"],
    image: json["image"],
    jwtToken: json["jwt_token"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "custom_user_token": customUserToken,
    "fcmToken": fcmToken,
    "mobile": mobile,
    "refercode": refercode,
    "username": username,
    "email": email,
    "device_id": deviceId,
    "dob": dob,
    "gender": gender,
    "address": address,
    "city": city,
    "pincode": pincode,
    "email_verify": emailVerify,
    "mobile_verify": mobileVerify,
    "bank_verify": bankVerify,
    "pan_verify": panVerify,
    "team": team,
    "user_profile_image": userProfileImage,
    "image": image,
    "jwt_token": jwtToken,
  };
}
