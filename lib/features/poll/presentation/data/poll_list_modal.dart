// To parse this JSON data, do
//
//     final pollListModal = pollListModalFromJson(jsonString);

import 'dart:convert';

PollListModal pollListModalFromJson(String str) => PollListModal.fromJson(json.decode(str));

String pollListModalToJson(PollListModal data) => json.encode(data.toJson());

class PollListModal {
  bool? success;
  List<Poll>? polls;

  PollListModal({
    this.success,
    this.polls,
  });

  factory PollListModal.fromJson(Map<String, dynamic> json) => PollListModal(
    success: json["success"],
    polls: json["polls"] == null ? [] : List<Poll>.from(json["polls"]!.map((x) => Poll.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "polls": polls == null ? [] : List<dynamic>.from(polls!.map((x) => x.toJson())),
  };
}

class Poll {
  int? id;
  String? topic;
  dynamic description;
  DateTime? startAt;
  DateTime? endAt;
  DateTime? expiryDate;
  String? status;
  int? voteOption;
  bool? expire;
  dynamic totalVotes;
  List<Option>? options;

  Poll({
    this.id,
    this.topic,
    this.description,
    this.startAt,
    this.endAt,
    this.expiryDate,
    this.status,
    this.voteOption,
    this.expire,
    this.totalVotes,
    this.options,
  });

  factory Poll.fromJson(Map<String, dynamic> json) => Poll(
    id: json["id"],
    topic: json["topic"],
    description: json["description"],
    startAt: json["start_at"] == null ? null : DateTime.parse(json["start_at"]),
    endAt: json["end_at"] == null ? null : DateTime.parse(json["end_at"]),
    expiryDate: json["expiry_date"] == null ? null : DateTime.parse(json["expiry_date"]),
    status: json["status"],
    voteOption: json["voted_option"],
    expire: json["expired"],
    totalVotes: json["total_votes"],
    options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "topic": topic,
    "description": description,
    "start_at": startAt?.toIso8601String(),
    "end_at": endAt?.toIso8601String(),
    "expiry_date": expiryDate?.toIso8601String(),
    "status": status,
    "total_votes": totalVotes,
    "voted_option": voteOption,
    "expired": expire,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
  };
}

class Option {
  int? id;
  String? optionText;
  int? voteCount;
  double? votePercentage;

  Option({
    this.id,
    this.optionText,
    this.voteCount,
    this.votePercentage,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json["id"],
    optionText: json["option_text"],
    voteCount: json["vote_count"],
    votePercentage: json["vote_percentage"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "option_text": optionText,
    "vote_count": voteCount,
    "vote_percentage": votePercentage,
  };
}
