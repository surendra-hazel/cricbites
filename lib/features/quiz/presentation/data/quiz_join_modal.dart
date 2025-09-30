// To parse this JSON data, do
//
//     final quizJoinModal = quizJoinModalFromJson(jsonString);

import 'dart:convert';

import 'package:Cricbites/features/quiz/presentation/data/quiz_list_modal.dart';

QuizJoinModal quizJoinModalFromJson(String str) => QuizJoinModal.fromJson(json.decode(str));

String quizJoinModalToJson(QuizJoinModal data) => json.encode(data.toJson());

class QuizJoinModal {
  bool? status;
  String? message;
  int? totalParticipation;
  List<Option>? options;

  QuizJoinModal({
    this.status,
    this.message,
    this.totalParticipation,
    this.options,
  });

  factory QuizJoinModal.fromJson(Map<String, dynamic> json) => QuizJoinModal(
    status: json["status"],
    message: json["message"],
    totalParticipation: json["total_participation"],
    options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "total_participation": totalParticipation,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
  };
}

// class Option {
//   int? id;
//   String? text;
//   int? participation;
//   int? percentage;
//   bool? isCorrect;
//
//   Option({
//     this.id,
//     this.text,
//     this.participation,
//     this.percentage,
//     this.isCorrect,
//   });
//
//   factory Option.fromJson(Map<String, dynamic> json) => Option(
//     id: json["id"],
//     text: json["text"],
//     participation: json["participation"],
//     percentage: json["percentage"],
//     isCorrect: json["is_correct"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "text": text,
//     "participation": participation,
//     "percentage": percentage,
//     "is_correct": isCorrect,
//   };
// }
