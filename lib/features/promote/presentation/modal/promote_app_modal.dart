// To parse this JSON data, do
//
//     final promoteAppModal = promoteAppModalFromJson(jsonString);

import 'dart:convert';

PromoteAppModal promoteAppModalFromJson(String str) => PromoteAppModal.fromJson(json.decode(str));

String promoteAppModalToJson(PromoteAppModal data) => json.encode(data.toJson());

class PromoteAppModal {
  int? status;
  String? message;

  PromoteAppModal({
    this.status,
    this.message,
  });

  factory PromoteAppModal.fromJson(Map<String, dynamic> json) => PromoteAppModal(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
