// To parse this JSON data, do
//
//     final setProfileModal = setProfileModalFromJson(jsonString);

import 'dart:convert';

SetProfileModal setProfileModalFromJson(String str) => SetProfileModal.fromJson(json.decode(str));

String setProfileModalToJson(SetProfileModal data) => json.encode(data.toJson());

class SetProfileModal {
  int? status;
  String? message;
  Result? result;

  SetProfileModal({
    this.status,
    this.message,
    this.result,
  });

  factory SetProfileModal.fromJson(Map<String, dynamic> json) => SetProfileModal(
    status: json["status"],
    message: json["message"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result?.toJson(),
  };
}

class Result {
  int? id;
  String? username;
  dynamic email;
  String? dob;
  String? gender;
  String? image;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? activationStatus;

  Result({
    this.id,
    this.username,
    this.email,
    this.dob,
    this.gender,
    this.image,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.activationStatus,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    dob: json["dob"],
    gender: json["gender"],
    image: json["image"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    pincode: json["pincode"],
    activationStatus: json["activation_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "dob": dob,
    "gender": gender,
    "image": image,
    "city": city,
    "state": state,
    "country": country,
    "pincode": pincode,
    "activation_status": activationStatus,
  };
}
