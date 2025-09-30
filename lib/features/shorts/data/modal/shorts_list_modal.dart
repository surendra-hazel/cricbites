// To parse this JSON data, do
//
//     final shortsListModal = shortsListModalFromJson(jsonString);

import 'dart:convert';

ShortsListModal shortsListModalFromJson(String str) => ShortsListModal.fromJson(json.decode(str));

String shortsListModalToJson(ShortsListModal data) => json.encode(data.toJson());

class ShortsListModal {
  String? kind;
  String? etag;
  String? regionCode;
  String? nextPageToken;
  PageInfo? pageInfo;
  List<YouTubeShorts>? items;

  ShortsListModal({
    this.kind,
    this.etag,
    this.regionCode,
    this.nextPageToken,
    this.pageInfo,
    this.items,
  });

  factory ShortsListModal.fromJson(Map<String, dynamic> json) => ShortsListModal(
    kind: json["kind"],
    etag: json["etag"],
    regionCode: json["regionCode"],
    nextPageToken: json["nextPageToken"],
    pageInfo: json["pageInfo"] == null ? null : PageInfo.fromJson(json["pageInfo"]),
    items: json["items"] == null ? [] : List<YouTubeShorts>.from(json["items"]!.map((x) => YouTubeShorts.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "etag": etag,
    "regionCode": regionCode,
    "nextPageToken": nextPageToken,
    "pageInfo": pageInfo?.toJson(),
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class YouTubeShorts {
  String? kind;
  String? etag;
  Id? id;
  Snippet? snippet;

  YouTubeShorts({
    this.kind,
    this.etag,
    this.id,
    this.snippet,
  });

  factory YouTubeShorts.fromJson(Map<String, dynamic> json) => YouTubeShorts(
    kind: json["kind"],
    etag: json["etag"],
    id: json["id"] == null ? null : Id.fromJson(json["id"]),
    snippet: json["snippet"] == null ? null : Snippet.fromJson(json["snippet"]),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "etag": etag,
    "id": id?.toJson(),
    "snippet": snippet?.toJson(),
  };
}

class Id {
  String? kind;
  String? videoId;

  Id({
    this.kind,
    this.videoId,
  });

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    kind: json["kind"],
    videoId: json["videoId"],
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "videoId": videoId,
  };
}

class Snippet {
  DateTime? publishedAt;
  String? channelId;
  String? title;
  String? description;
  Thumbnails? thumbnails;
  String? channelTitle;
  String? liveBroadcastContent;
  DateTime? publishTime;

  Snippet({
    this.publishedAt,
    this.channelId,
    this.title,
    this.description,
    this.thumbnails,
    this.channelTitle,
    this.liveBroadcastContent,
    this.publishTime,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
    publishedAt: json["publishedAt"] == null ? null : DateTime.parse(json["publishedAt"]),
    channelId: json["channelId"],
    title: json["title"],
    description: json["description"],
    thumbnails: json["thumbnails"] == null ? null : Thumbnails.fromJson(json["thumbnails"]),
    channelTitle: json["channelTitle"],
    liveBroadcastContent: json["liveBroadcastContent"],
    publishTime: json["publishTime"] == null ? null : DateTime.parse(json["publishTime"]),
  );

  Map<String, dynamic> toJson() => {
    "publishedAt": publishedAt?.toIso8601String(),
    "channelId": channelId,
    "title": title,
    "description": description,
    "thumbnails": thumbnails?.toJson(),
    "channelTitle": channelTitle,
    "liveBroadcastContent": liveBroadcastContent,
    "publishTime": publishTime?.toIso8601String(),
  };
}

class Thumbnails {
  Default? thumbnailsDefault;
  Default? medium;
  Default? high;

  Thumbnails({
    this.thumbnailsDefault,
    this.medium,
    this.high,
  });

  factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
    thumbnailsDefault: json["default"] == null ? null : Default.fromJson(json["default"]),
    medium: json["medium"] == null ? null : Default.fromJson(json["medium"]),
    high: json["high"] == null ? null : Default.fromJson(json["high"]),
  );

  Map<String, dynamic> toJson() => {
    "default": thumbnailsDefault?.toJson(),
    "medium": medium?.toJson(),
    "high": high?.toJson(),
  };
}

class Default {
  String? url;
  int? width;
  int? height;

  Default({
    this.url,
    this.width,
    this.height,
  });

  factory Default.fromJson(Map<String, dynamic> json) => Default(
    url: json["url"],
    width: json["width"],
    height: json["height"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "width": width,
    "height": height,
  };
}

class PageInfo {
  int? totalResults;
  int? resultsPerPage;

  PageInfo({
    this.totalResults,
    this.resultsPerPage,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    totalResults: json["totalResults"],
    resultsPerPage: json["resultsPerPage"],
  );

  Map<String, dynamic> toJson() => {
    "totalResults": totalResults,
    "resultsPerPage": resultsPerPage,
  };
}
