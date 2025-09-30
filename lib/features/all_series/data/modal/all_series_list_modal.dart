// To parse this JSON data, do
//
//     final allSeriesListModal = allSeriesListModalFromJson(jsonString);

import 'dart:convert';

AllSeriesListModal allSeriesListModalFromJson(String str) => AllSeriesListModal.fromJson(json.decode(str));

String allSeriesListModalToJson(AllSeriesListModal data) => json.encode(data.toJson());

class AllSeriesListModal {
  String? status;
  Response? response;

  AllSeriesListModal({
    this.status,
    this.response,
  });

  factory AllSeriesListModal.fromJson(Map<String, dynamic> json) => AllSeriesListModal(
    status: json["status"],
    response: json["response"] == null ? null : Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "response": response?.toJson(),
  };
}

class Response {
  List<SeriesList>? items;
  int? totalItems;
  int? totalPages;

  Response({
    this.items,
    this.totalItems,
    this.totalPages,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    items: json["items"] == null ? [] : List<SeriesList>.from(json["items"]!.map((x) => SeriesList.fromJson(x))),
    totalItems: json["total_items"],
    totalPages: json["total_pages"],
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "total_items": totalItems,
    "total_pages": totalPages,
  };
}

class SeriesList {
  int? cid;
  String? title;
  String? abbr;
  String? category;
  String? status;
  String? gameFormat;
  String? season;
  DateTime? datestart;
  DateTime? dateend;
  String? country;
  String? totalMatches;
  String? totalRounds;
  String? totalTeams;

  SeriesList({
    this.cid,
    this.title,
    this.abbr,
    this.category,
    this.status,
    this.gameFormat,
    this.season,
    this.datestart,
    this.dateend,
    this.country,
    this.totalMatches,
    this.totalRounds,
    this.totalTeams,
  });

  factory SeriesList.fromJson(Map<String, dynamic> json) => SeriesList(
    cid: json["cid"],
    title: json["title"],
    abbr: json["abbr"],
    category: json["category"],
    status: json["status"],
    gameFormat: json["game_format"],
    season: json["season"],
    datestart: json["datestart"] == null ? null : DateTime.parse(json["datestart"]),
    dateend: json["dateend"] == null ? null : DateTime.parse(json["dateend"]),
    country: json["country"],
    totalMatches: json["total_matches"],
    totalRounds: json["total_rounds"],
    totalTeams: json["total_teams"],
  );

  Map<String, dynamic> toJson() => {
    "cid": cid,
    "title": title,
    "abbr": abbr,
    "category": category,
    "status": status,
    "game_format": gameFormat,
    "season": season,
    "datestart": "${datestart!.year.toString().padLeft(4, '0')}-${datestart!.month.toString().padLeft(2, '0')}-${datestart!.day.toString().padLeft(2, '0')}",
    "dateend": "${dateend!.year.toString().padLeft(4, '0')}-${dateend!.month.toString().padLeft(2, '0')}-${dateend!.day.toString().padLeft(2, '0')}",
    "country": country,
    "total_matches": totalMatches,
    "total_rounds": totalRounds,
    "total_teams": totalTeams,
  };
}
