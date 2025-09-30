// To parse this JSON data, do
//
//     final feedbackModal = feedbackModalFromJson(jsonString);

import 'dart:convert';

FeedbackModal feedbackModalFromJson(String str) => FeedbackModal.fromJson(json.decode(str));

String feedbackModalToJson(FeedbackModal data) => json.encode(data.toJson());

class FeedbackModal {
  int? status;
  Result? result;

  FeedbackModal({
    this.status,
    this.result,
  });

  factory FeedbackModal.fromJson(Map<String, dynamic> json) => FeedbackModal(
    status: json["status"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result?.toJson(),
  };
}

class Result {
  String? email;
  String? mobile;
  String? fullName;
  String? category;
  String? subject;
  String? description;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Result({
    this.email,
    this.mobile,
    this.fullName,
    this.category,
    this.subject,
    this.description,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    email: json["email"],
    mobile: json["mobile"],
    fullName: json["full_name"],
    category: json["category"],
    subject: json["subject"],
    description: json["description"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "mobile": mobile,
    "full_name": fullName,
    "category": category,
    "subject": subject,
    "description": description,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
