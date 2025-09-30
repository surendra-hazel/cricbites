// To parse this JSON data, do
//
//     final scheduleListModal = scheduleListModalFromJson(jsonString);

import 'dart:convert';

ScheduleListModal scheduleListModalFromJson(String str) => ScheduleListModal.fromJson(json.decode(str));

String scheduleListModalToJson(ScheduleListModal data) => json.encode(data.toJson());

class ScheduleListModal {
  int? status;
  List<Heading>? heading;
  List<ScheduleList>? data;

  ScheduleListModal({
    this.status,
    this.heading,
    this.data,
  });

  factory ScheduleListModal.fromJson(Map<String, dynamic> json) => ScheduleListModal(
    status: json["status"],
    heading: json["heading"] == null ? [] : List<Heading>.from(json["heading"]!.map((x) => Heading.fromJson(x))),
    data: json["data"] == null ? [] : List<ScheduleList>.from(json["data"]!.map((x) => ScheduleList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "heading": heading == null ? [] : List<dynamic>.from(heading!.map((x) => x.toJson())),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ScheduleList {
  int? compId;
  String? compName;
  String? tournament;
  int? matchId;
  String? matchLocation;
  Team? team1;
  Team? team2;
  DateTime? startDate;
  String? status;
  String? statusNote;
  String? matchNumber;
  String? matchFormat;

  ScheduleList({
    this.compId,
    this.compName,
    this.tournament,
    this.matchId,
    this.matchLocation,
    this.team1,
    this.team2,
    this.startDate,
    this.status,
    this.statusNote,
    this.matchNumber,
    this.matchFormat,
  });

  factory ScheduleList.fromJson(Map<String, dynamic> json) => ScheduleList(
    compId: json["comp_id"],
    compName: json["comp_name"],
    tournament: json["tournament"],
    matchId: json["match_id"],
    matchLocation: json["match_location"],
    team1: json["team1"] == null ? null : Team.fromJson(json["team1"]),
    team2: json["team2"] == null ? null : Team.fromJson(json["team2"]),
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    status: json["status"],
    statusNote: json["status_note"],
    matchNumber: json["match_number"],
    matchFormat: json["match_format"],
  );

  Map<String, dynamic> toJson() => {
    "comp_id": compId,
    "comp_name": compName,
    "tournament": tournament,
    "match_id": matchId,
    "match_location": matchLocation,
    "team1": team1?.toJson(),
    "team2": team2?.toJson(),
    "start_date": startDate?.toIso8601String(),
    "status": status,
    "status_note": statusNote,
    "match_number": matchNumber,
    "match_format": matchFormat,
  };
}

class Team {
  int? teamId;
  String? name;
  String? shortName;
  String? logoUrl;
  String? scoresFull;
  String? scores;
  String? overs;

  Team({
    this.teamId,
    this.name,
    this.shortName,
    this.logoUrl,
    this.scoresFull,
    this.scores,
    this.overs,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    teamId: json["team_id"],
    name: json["name"],
    shortName: json["short_name"],
    logoUrl: json["logo_url"],
    scoresFull: (json["scores_full"] == null || json["scores_full"].toString().trim().isEmpty)
        ? "Yet to bat"
        : json["scores_full"],
    scores: json["scores"],
    overs: json["overs"],
  );

  Map<String, dynamic> toJson() => {
    "team_id": teamId,
    "name": name,
    "short_name": shortName,
    "logo_url": logoUrl,
    "scores_full": scoresFull,
    "scores": scores,
    "overs": overs,
  };
}

class Heading {
  int? compId;
  String? compName;

  Heading({
    this.compId,
    this.compName,
  });

  factory Heading.fromJson(Map<String, dynamic> json) => Heading(
    compId: json["comp_id"],
    compName: json["comp_name"],
  );

  Map<String, dynamic> toJson() => {
    "comp_id": compId,
    "comp_name": compName,
  };
}
