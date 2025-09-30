// To parse this JSON data, do
//
//     final quizListModal = quizListModalFromJson(jsonString);

import 'dart:convert';

QuizListModal quizListModalFromJson(String str) => QuizListModal.fromJson(json.decode(str));

String quizListModalToJson(QuizListModal data) => json.encode(data.toJson());

class QuizListModal {
  bool? status;
  List<Quiz>? quizzes;

  QuizListModal({
    this.status,
    this.quizzes,
  });

  factory QuizListModal.fromJson(Map<String, dynamic> json) => QuizListModal(
    status: json["status"],
    quizzes: json["quizzes"] == null ? [] : List<Quiz>.from(json["quizzes"]!.map((x) => Quiz.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "quizzes": quizzes == null ? [] : List<dynamic>.from(quizzes!.map((x) => x.toJson())),
  };
}

class Quiz {
  int? id;
  String? title;
  String? description;
  String? gift;
  int? totalParticipation;
  DateTime? expiryDate;
  int? voteOption;
  bool? expire;
  List<Option>? options;

  Quiz({
    this.id,
    this.title,
    this.description,
    this.expiryDate,
    this.gift,
    this.totalParticipation,
    this.voteOption,
    this.expire,
    this.options,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    gift: json["gift"],
    totalParticipation: json["total_participation"],
    voteOption: json["voted_option"],
    expire: json["expired"],
    expiryDate: json["expiry_date"] == null ? null : DateTime.parse(json["expiry_date"]),
    options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "gift": gift,
    "total_participation": totalParticipation,
    "voted_option": voteOption,
    "expiry_date": expiryDate?.toIso8601String(),
    "expired": expire,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
  };
}

class Option {
  int? id;
  String? text;
  int? participation;
  num? percentage;
  bool? isCorrect;

  Option({
    this.id,
    this.text,
    this.participation,
    this.percentage,
    this.isCorrect,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json["id"],
    text: json["text"],
    participation: json["participation"],
    percentage: json["percentage"],
    isCorrect: json["is_correct"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "participation": participation,
    "percentage": percentage,
    "is_correct": isCorrect,
  };
}
