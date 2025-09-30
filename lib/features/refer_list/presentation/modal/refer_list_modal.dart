// To parse this JSON data, do
//
//     final referListModal = referListModalFromJson(jsonString);

import 'dart:convert';

ReferListModal referListModalFromJson(String str) => ReferListModal.fromJson(json.decode(str));

String referListModalToJson(ReferListModal data) => json.encode(data.toJson());

class ReferListModal {
  int? status;
  int? totalUser;
  String? totalAmount;
  int? totalPages;
  int? level;
  List<ReferralList>? result;

  ReferListModal({
    this.status,
    this.totalUser,
    this.totalAmount,
    this.totalPages,
    this.level,
    this.result,
  });

  factory ReferListModal.fromJson(Map<String, dynamic> json) => ReferListModal(
    status: json["status"],
    totalUser: json["total_user"],
    totalAmount: json["total_amount"],
    totalPages: json["total_pages"],
    level: json["level"],
    result: json["result"] == null ? [] : List<ReferralList>.from(json["result"]!.map((x) => ReferralList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "total_user": totalUser,
    "total_amount": totalAmount,
    "total_pages": totalPages,
    "level": level,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class ReferralList {
  int? id;
  String? mobile;
  String? name;
  String? amount;
  int? level;

  ReferralList({
    this.id,
    this.mobile,
    this.name,
    this.amount,
    this.level,
  });

  factory ReferralList.fromJson(Map<String, dynamic> json) => ReferralList(
    id: json["id"],
    mobile: json["mobile"],
    name: json["name"],
    amount: json["Amount"],
    level: json["level"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mobile": mobile,
    "name": name,
    "Amount": amount,
    "level": level,
  };
}
