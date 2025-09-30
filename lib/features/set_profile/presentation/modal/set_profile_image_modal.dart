// To parse this JSON data, do
//
//     final setProfileImageModal = setProfileImageModalFromJson(jsonString);

import 'dart:convert';

SetProfileImageModal setProfileImageModalFromJson(String str) => SetProfileImageModal.fromJson(json.decode(str));

String setProfileImageModalToJson(SetProfileImageModal data) => json.encode(data.toJson());

class SetProfileImageModal {
  int? status;
  String? message;
  String? file;

  SetProfileImageModal({
    this.status,
    this.message,
    this.file,
  });

  factory SetProfileImageModal.fromJson(Map<String, dynamic> json) => SetProfileImageModal(
    status: json["status"],
    message: json["message"],
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "file": file,
  };
}
