// To parse this JSON data, do
//
//     final pollVoteModal = pollVoteModalFromJson(jsonString);

import 'dart:convert';

PollVoteModal pollVoteModalFromJson(String str) => PollVoteModal.fromJson(json.decode(str));

String pollVoteModalToJson(PollVoteModal data) => json.encode(data.toJson());

class PollVoteModal {
  bool? success;
  String? message;
  int? pollId;
  int? optionId;
  String? totalVotes;
  int? optionVoteCount;
  num? optionVotePercentage;

  PollVoteModal({
    this.success,
    this.message,
    this.pollId,
    this.optionId,
    this.totalVotes,
    this.optionVoteCount,
    this.optionVotePercentage,
  });

  factory PollVoteModal.fromJson(Map<String, dynamic> json) => PollVoteModal(
    success: json["success"],
    message: json["message"],
    pollId: json["poll_id"],
    optionId: json["option_id"],
    totalVotes: json["total_votes"],
    optionVoteCount: json["option_vote_count"],
    optionVotePercentage: json["option_vote_percentage"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "poll_id": pollId,
    "option_id": optionId,
    "total_votes": totalVotes,
    "option_vote_count": optionVoteCount,
    "option_vote_percentage": optionVotePercentage,
  };
}
