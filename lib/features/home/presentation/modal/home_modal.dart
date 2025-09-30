// To parse this JSON data, do
//
//     final homePageModal = homePageModalFromJson(jsonString);

import 'dart:convert';

HomePageModal homePageModalFromJson(String str) => HomePageModal.fromJson(json.decode(str));

String homePageModalToJson(HomePageModal data) => json.encode(data.toJson());

class HomePageModal {
  int? status;
  HomePageModalData? data;

  HomePageModal({
    this.status,
    this.data,
  });

  factory HomePageModal.fromJson(Map<String, dynamic> json) => HomePageModal(
    status: json["status"],
    data: json["data"] == null ? null : HomePageModalData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class HomePageModalData {
  String? status;
  String? message;
  DataData? data;

  HomePageModalData({
    this.status,
    this.message,
    this.data,
  });

  factory HomePageModalData.fromJson(Map<String, dynamic> json) => HomePageModalData(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : DataData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class DataData {
  Navigation? navigation;
  List<MatchFilter>? matchFilters;
  List<LiveMatch>? liveMatches;
  List<CricketStory>? cricketStories;
  FeaturedPlayer? featuredPlayer;
  List<TourMatch>? tourMatches;
  List<CurrentSery>? currentSeries;
  List<CricketStory>? latestNews;
  AppMetadata? appMetadata;

  DataData({
    this.navigation,
    this.matchFilters,
    this.liveMatches,
    this.cricketStories,
    this.featuredPlayer,
    this.tourMatches,
    this.currentSeries,
    this.latestNews,
    this.appMetadata,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
    navigation: json["navigation"] == null ? null : Navigation.fromJson(json["navigation"]),
    matchFilters: json["match_filters"] == null ? [] : List<MatchFilter>.from(json["match_filters"]!.map((x) => MatchFilter.fromJson(x))),
    liveMatches: json["live_matches"] == null ? [] : List<LiveMatch>.from(json["live_matches"]!.map((x) => LiveMatch.fromJson(x))),
    cricketStories: json["cricket_stories"] == null ? [] : List<CricketStory>.from(json["cricket_stories"]!.map((x) => CricketStory.fromJson(x))),
    featuredPlayer: json["featured_player"] == null ? null : FeaturedPlayer.fromJson(json["featured_player"]),
    tourMatches: json["tour_matches"] == null ? [] : List<TourMatch>.from(json["tour_matches"]!.map((x) => TourMatch.fromJson(x))),
    currentSeries: json["current_series"] == null ? [] : List<CurrentSery>.from(json["current_series"]!.map((x) => CurrentSery.fromJson(x))),
    latestNews: json["latest_news"] == null ? [] : List<CricketStory>.from(json["latest_news"]!.map((x) => CricketStory.fromJson(x))),
    appMetadata: json["app_metadata"] == null ? null : AppMetadata.fromJson(json["app_metadata"]),
  );

  Map<String, dynamic> toJson() => {
    "navigation": navigation?.toJson(),
    "match_filters": matchFilters == null ? [] : List<dynamic>.from(matchFilters!.map((x) => x.toJson())),
    "live_matches": liveMatches == null ? [] : List<dynamic>.from(liveMatches!.map((x) => x.toJson())),
    "cricket_stories": cricketStories == null ? [] : List<dynamic>.from(cricketStories!.map((x) => x.toJson())),
    "featured_player": featuredPlayer?.toJson(),
    "tour_matches": tourMatches == null ? [] : List<dynamic>.from(tourMatches!.map((x) => x.toJson())),
    "current_series": currentSeries == null ? [] : List<dynamic>.from(currentSeries!.map((x) => x.toJson())),
    "latest_news": latestNews == null ? [] : List<dynamic>.from(latestNews!.map((x) => x.toJson())),
    "app_metadata": appMetadata?.toJson(),
  };
}

class AppMetadata {
  DateTime? lastUpdated;
  String? apiVersion;
  String? timezone;
  int? totalSections;
  int? cacheDuration;
  RefreshIntervals? refreshIntervals;

  AppMetadata({
    this.lastUpdated,
    this.apiVersion,
    this.timezone,
    this.totalSections,
    this.cacheDuration,
    this.refreshIntervals,
  });

  factory AppMetadata.fromJson(Map<String, dynamic> json) => AppMetadata(
    lastUpdated: json["last_updated"] == null ? null : DateTime.parse(json["last_updated"]),
    apiVersion: json["api_version"],
    timezone: json["timezone"],
    totalSections: json["total_sections"],
    cacheDuration: json["cache_duration"],
    refreshIntervals: json["refresh_intervals"] == null ? null : RefreshIntervals.fromJson(json["refresh_intervals"]),
  );

  Map<String, dynamic> toJson() => {
    "last_updated": lastUpdated?.toIso8601String(),
    "api_version": apiVersion,
    "timezone": timezone,
    "total_sections": totalSections,
    "cache_duration": cacheDuration,
    "refresh_intervals": refreshIntervals?.toJson(),
  };
}

class RefreshIntervals {
  int? liveMatches;
  int? cricketStories;
  int? news;
  int? series;

  RefreshIntervals({
    this.liveMatches,
    this.cricketStories,
    this.news,
    this.series,
  });

  factory RefreshIntervals.fromJson(Map<String, dynamic> json) => RefreshIntervals(
    liveMatches: json["live_matches"],
    cricketStories: json["cricket_stories"],
    news: json["news"],
    series: json["series"],
  );

  Map<String, dynamic> toJson() => {
    "live_matches": liveMatches,
    "cricket_stories": cricketStories,
    "news": news,
    "series": series,
  };
}

class CricketStory {
  int? id;
  String? title;
  String? image;
  String? category;
  String? readTime;
  DateTime? publishedAt;
  String? author;
  List<String>? tags;
  String? summary;

  CricketStory({
    this.id,
    this.title,
    this.image,
    this.category,
    this.readTime,
    this.publishedAt,
    this.author,
    this.tags,
    this.summary,
  });

  factory CricketStory.fromJson(Map<String, dynamic> json) => CricketStory(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    category: json["category"],
    readTime: json["read_time"],
    publishedAt: json["published_at"] == null ? null : DateTime.parse(json["published_at"]),
    author: json["author"],
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
    summary: json["summary"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "category": category,
    "read_time": readTime,
    "published_at": publishedAt?.toIso8601String(),
    "author": author,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "summary": summary,
  };
}

class CurrentSery {
  int? id;
  String? name;
  String? image;
  String? status;
  String? format;
  int? teamsCount;
  int? matchesPlayed;
  int? matchesTotal;
  DateTime? startDate;
  DateTime? endDate;
  List<CurrentStanding>? currentStandings;
  List<String>? participatingTeams;
  String? winner;
  String? finalResult;

  CurrentSery({
    this.id,
    this.name,
    this.image,
    this.status,
    this.format,
    this.teamsCount,
    this.matchesPlayed,
    this.matchesTotal,
    this.startDate,
    this.endDate,
    this.currentStandings,
    this.participatingTeams,
    this.winner,
    this.finalResult,
  });

  factory CurrentSery.fromJson(Map<String, dynamic> json) => CurrentSery(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    status: json["status"],
    format: json["format"],
    teamsCount: json["teams_count"],
    matchesPlayed: json["matches_played"],
    matchesTotal: json["matches_total"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    currentStandings: json["current_standings"] == null ? [] : List<CurrentStanding>.from(json["current_standings"]!.map((x) => CurrentStanding.fromJson(x))),
    participatingTeams: json["participating_teams"] == null ? [] : List<String>.from(json["participating_teams"]!.map((x) => x)),
    winner: json["winner"],
    finalResult: json["final_result"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "status": status,
    "format": format,
    "teams_count": teamsCount,
    "matches_played": matchesPlayed,
    "matches_total": matchesTotal,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "current_standings": currentStandings == null ? [] : List<dynamic>.from(currentStandings!.map((x) => x.toJson())),
    "participating_teams": participatingTeams == null ? [] : List<dynamic>.from(participatingTeams!.map((x) => x)),
    "winner": winner,
    "final_result": finalResult,
  };
}

class CurrentStanding {
  String? team;
  int? points;
  int? matches;

  CurrentStanding({
    this.team,
    this.points,
    this.matches,
  });

  factory CurrentStanding.fromJson(Map<String, dynamic> json) => CurrentStanding(
    team: json["team"],
    points: json["points"],
    matches: json["matches"],
  );

  Map<String, dynamic> toJson() => {
    "team": team,
    "points": points,
    "matches": matches,
  };
}

class FeaturedPlayer {
  String? name;
  String? image;
  String? title;
  Stats? stats;

  FeaturedPlayer({
    this.name,
    this.image,
    this.title,
    this.stats,
  });

  factory FeaturedPlayer.fromJson(Map<String, dynamic> json) => FeaturedPlayer(
    name: json["name"],
    image: json["image"],
    title: json["title"],
    stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "title": title,
    "stats": stats?.toJson(),
  };
}

class Stats {
  int? matches;
  int? runs;
  double? average;
  int? centuries;

  Stats({
    this.matches,
    this.runs,
    this.average,
    this.centuries,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    matches: json["matches"],
    runs: json["runs"],
    average: json["average"]?.toDouble(),
    centuries: json["centuries"],
  );

  Map<String, dynamic> toJson() => {
    "matches": matches,
    "runs": runs,
    "average": average,
    "centuries": centuries,
  };
}

class LiveMatch {
  int? id;
  String? matchType;
  String? tournament;
  String? status;
  LiveMatchTeams? teams;
  String? result;
  String? venue;
  DateTime? matchTime;
  bool? isLive;
  String? liveStatus;

  LiveMatch({
    this.id,
    this.matchType,
    this.tournament,
    this.status,
    this.teams,
    this.result,
    this.venue,
    this.matchTime,
    this.isLive,
    this.liveStatus,
  });

  factory LiveMatch.fromJson(Map<String, dynamic> json) => LiveMatch(
    id: json["id"],
    matchType: json["match_type"],
    tournament: json["tournament"],
    status: json["status"],
    teams: json["teams"] == null ? null : LiveMatchTeams.fromJson(json["teams"]),
    result: json["result"],
    venue: json["venue"],
    matchTime: json["match_time"] == null ? null : DateTime.parse(json["match_time"]),
    isLive: json["is_live"],
    liveStatus: json["live_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "match_type": matchType,
    "tournament": tournament,
    "status": status,
    "teams": teams?.toJson(),
    "result": result,
    "venue": venue,
    "match_time": matchTime?.toIso8601String(),
    "is_live": isLive,
    "live_status": liveStatus,
  };
}

class LiveMatchTeams {
  Team? teamA;
  Team? teamB;

  LiveMatchTeams({
    this.teamA,
    this.teamB,
  });

  factory LiveMatchTeams.fromJson(Map<String, dynamic> json) => LiveMatchTeams(
    teamA: json["team_a"] == null ? null : Team.fromJson(json["team_a"]),
    teamB: json["team_b"] == null ? null : Team.fromJson(json["team_b"]),
  );

  Map<String, dynamic> toJson() => {
    "team_a": teamA?.toJson(),
    "team_b": teamB?.toJson(),
  };
}

class Team {
  String? name;
  String? shortName;
  String? flag;
  String? score;
  String? overs;

  Team({
    this.name,
    this.shortName,
    this.flag,
    this.score,
    this.overs,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    name: json["name"],
    shortName: json["short_name"],
    flag: json["flag"],
    score: json["score"],
    overs: json["overs"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "short_name": shortName,
    "flag": flag,
    "score": score,
    "overs": overs,
  };
}

class MatchFilter {
  int? id;
  String? name;
  bool? isActive;
  dynamic count;

  MatchFilter({
    this.id,
    this.name,
    this.isActive,
    this.count,
  });

  factory MatchFilter.fromJson(Map<String, dynamic> json) => MatchFilter(
    id: json["id"],
    name: json["name"],
    isActive: json["is_active"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "is_active": isActive,
    "count": count,
  };
}

class Navigation {
  List<NavigationTab>? tabs;

  Navigation({
    this.tabs,
  });

  factory Navigation.fromJson(Map<String, dynamic> json) => Navigation(
    tabs: json["tabs"] == null ? [] : List<NavigationTab>.from(json["tabs"]!.map((x) => NavigationTab.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tabs": tabs == null ? [] : List<dynamic>.from(tabs!.map((x) => x.toJson())),
  };
}

class NavigationTab {
  int? id;
  String? name;
  String? slug;
  bool? isActive;
  String? icon;

  NavigationTab({
    this.id,
    this.name,
    this.slug,
    this.isActive,
    this.icon,
  });

  factory NavigationTab.fromJson(Map<String, dynamic> json) => NavigationTab(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    isActive: json["is_active"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "is_active": isActive,
    "icon": icon,
  };
}

class TourMatch {
  int? id;
  String? tourName;
  String? tourType;
  String? tourSlug;
  DateTime? startDate;
  DateTime? endDate;
  List<Match>? matches;
  List<PromotionalMatch>? promotionalMatches;

  TourMatch({
    this.id,
    this.tourName,
    this.tourType,
    this.tourSlug,
    this.startDate,
    this.endDate,
    this.matches,
    this.promotionalMatches,
  });

  factory TourMatch.fromJson(Map<String, dynamic> json) => TourMatch(
    id: json["id"],
    tourName: json["tour_name"],
    tourType: json["tour_type"],
    tourSlug: json["tour_slug"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    matches: json["matches"] == null ? [] : List<Match>.from(json["matches"]!.map((x) => Match.fromJson(x))),
    promotionalMatches: json["promotional_matches"] == null ? [] : List<PromotionalMatch>.from(json["promotional_matches"]!.map((x) => PromotionalMatch.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tour_name": tourName,
    "tour_type": tourType,
    "tour_slug": tourSlug,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "matches": matches == null ? [] : List<dynamic>.from(matches!.map((x) => x.toJson())),
    "promotional_matches": promotionalMatches == null ? [] : List<dynamic>.from(promotionalMatches!.map((x) => x.toJson())),
  };
}

class Match {
  int? matchId;
  String? matchNumber;
  String? venue;
  MatchTeams? teams;
  String? status;
  DateTime? startDate;
  String? matchType;
  List<MatchTab>? tabs;

  Match({
    this.matchId,
    this.matchNumber,
    this.venue,
    this.teams,
    this.status,
    this.startDate,
    this.matchType,
    this.tabs,
  });

  factory Match.fromJson(Map<String, dynamic> json) => Match(
    matchId: json["match_id"],
    matchNumber: json["match_number"],
    venue: json["venue"],
    teams: json["teams"] == null ? null : MatchTeams.fromJson(json["teams"]),
    status: json["status"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    matchType: json["match_type"],
    tabs: json["tabs"] == null ? [] : List<MatchTab>.from(json["tabs"]!.map((x) => MatchTab.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "match_id": matchId,
    "match_number": matchNumber,
    "venue": venue,
    "teams": teams?.toJson(),
    "status": status,
    "start_date": startDate?.toIso8601String(),
    "match_type": matchType,
    "tabs": tabs == null ? [] : List<dynamic>.from(tabs!.map((x) => x.toJson())),
  };
}

class MatchTab {
  String? name;
  bool? isActive;
  String? slug;
  TabData? data;

  MatchTab({
    this.name,
    this.isActive,
    this.slug,
    this.data,
  });

  factory MatchTab.fromJson(Map<String, dynamic> json) => MatchTab(
    name: json["name"],
    isActive: json["is_active"],
    slug: json["slug"],
    data: json["data"] == null ? null : TabData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "is_active": isActive,
    "slug": slug,
    "data": data?.toJson(),
  };
}

class TabData {
  VenueDetails? venueDetails;
  String? weather;
  String? pitchReport;
  HeadToHead? headToHead;
  RecentForm? recentForm;
  Squad? englandSquad;
  Squad? indiaSquad;
  Squad? southAfricaSquad;

  TabData({
    this.venueDetails,
    this.weather,
    this.pitchReport,
    this.headToHead,
    this.recentForm,
    this.englandSquad,
    this.indiaSquad,
    this.southAfricaSquad,
  });

  factory TabData.fromJson(Map<String, dynamic> json) => TabData(
    venueDetails: json["venue_details"] == null ? null : VenueDetails.fromJson(json["venue_details"]),
    weather: json["weather"],
    pitchReport: json["pitch_report"],
    headToHead: json["head_to_head"] == null ? null : HeadToHead.fromJson(json["head_to_head"]),
    recentForm: json["recent_form"] == null ? null : RecentForm.fromJson(json["recent_form"]),
    englandSquad: json["england_squad"] == null ? null : Squad.fromJson(json["england_squad"]),
    indiaSquad: json["india_squad"] == null ? null : Squad.fromJson(json["india_squad"]),
    southAfricaSquad: json["south_africa_squad"] == null ? null : Squad.fromJson(json["south_africa_squad"]),
  );

  Map<String, dynamic> toJson() => {
    "venue_details": venueDetails?.toJson(),
    "weather": weather,
    "pitch_report": pitchReport,
    "head_to_head": headToHead?.toJson(),
    "recent_form": recentForm?.toJson(),
    "england_squad": englandSquad?.toJson(),
    "india_squad": indiaSquad?.toJson(),
    "south_africa_squad": southAfricaSquad?.toJson(),
  };
}

class Squad {
  List<String>? batsmen;
  List<String>? bowlers;
  List<String>? wicketKeepers;

  Squad({
    this.batsmen,
    this.bowlers,
    this.wicketKeepers,
  });

  factory Squad.fromJson(Map<String, dynamic> json) => Squad(
    batsmen: json["batsmen"] == null ? [] : List<String>.from(json["batsmen"]!.map((x) => x)),
    bowlers: json["bowlers"] == null ? [] : List<String>.from(json["bowlers"]!.map((x) => x)),
    wicketKeepers: json["wicket_keepers"] == null ? [] : List<String>.from(json["wicket_keepers"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "batsmen": batsmen == null ? [] : List<dynamic>.from(batsmen!.map((x) => x)),
    "bowlers": bowlers == null ? [] : List<dynamic>.from(bowlers!.map((x) => x)),
    "wicket_keepers": wicketKeepers == null ? [] : List<dynamic>.from(wicketKeepers!.map((x) => x)),
  };
}

class HeadToHead {
  int? totalMatches;
  int? englandWins;
  int? indiaWins;
  int? draws;
  int? southAfricaWins;
  int? noResult;

  HeadToHead({
    this.totalMatches,
    this.englandWins,
    this.indiaWins,
    this.draws,
    this.southAfricaWins,
    this.noResult,
  });

  factory HeadToHead.fromJson(Map<String, dynamic> json) => HeadToHead(
    totalMatches: json["total_matches"],
    englandWins: json["england_wins"],
    indiaWins: json["india_wins"],
    draws: json["draws"],
    southAfricaWins: json["south_africa_wins"],
    noResult: json["no_result"],
  );

  Map<String, dynamic> toJson() => {
    "total_matches": totalMatches,
    "england_wins": englandWins,
    "india_wins": indiaWins,
    "draws": draws,
    "south_africa_wins": southAfricaWins,
    "no_result": noResult,
  };
}

class RecentForm {
  List<String>? england;
  List<String>? india;
  List<String>? southAfrica;

  RecentForm({
    this.england,
    this.india,
    this.southAfrica,
  });

  factory RecentForm.fromJson(Map<String, dynamic> json) => RecentForm(
    england: json["england"] == null ? [] : List<String>.from(json["england"]!.map((x) => x)),
    india: json["india"] == null ? [] : List<String>.from(json["india"]!.map((x) => x)),
    southAfrica: json["south_africa"] == null ? [] : List<String>.from(json["south_africa"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "england": england == null ? [] : List<dynamic>.from(england!.map((x) => x)),
    "india": india == null ? [] : List<dynamic>.from(india!.map((x) => x)),
    "south_africa": southAfrica == null ? [] : List<dynamic>.from(southAfrica!.map((x) => x)),
  };
}

class VenueDetails {
  String? name;
  String? city;
  int? capacity;

  VenueDetails({
    this.name,
    this.city,
    this.capacity,
  });

  factory VenueDetails.fromJson(Map<String, dynamic> json) => VenueDetails(
    name: json["name"],
    city: json["city"],
    capacity: json["capacity"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "city": city,
    "capacity": capacity,
  };
}

class MatchTeams {
  Away? home;
  Away? away;

  MatchTeams({
    this.home,
    this.away,
  });

  factory MatchTeams.fromJson(Map<String, dynamic> json) => MatchTeams(
    home: json["home"] == null ? null : Away.fromJson(json["home"]),
    away: json["away"] == null ? null : Away.fromJson(json["away"]),
  );

  Map<String, dynamic> toJson() => {
    "home": home?.toJson(),
    "away": away?.toJson(),
  };
}

class Away {
  String? name;
  String? shortName;
  String? flag;

  Away({
    this.name,
    this.shortName,
    this.flag,
  });

  factory Away.fromJson(Map<String, dynamic> json) => Away(
    name: json["name"],
    shortName: json["short_name"],
    flag: json["flag"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "short_name": shortName,
    "flag": flag,
  };
}

class PromotionalMatch {
  int? id;
  String? title;
  String? subtitle;
  String? date;
  String? duration;
  String? image;
  String? type;
  String? contentType;

  PromotionalMatch({
    this.id,
    this.title,
    this.subtitle,
    this.date,
    this.duration,
    this.image,
    this.type,
    this.contentType,
  });

  factory PromotionalMatch.fromJson(Map<String, dynamic> json) => PromotionalMatch(
    id: json["id"],
    title: json["title"],
    subtitle: json["subtitle"],
    date: json["date"],
    duration: json["duration"],
    image: json["image"],
    type: json["type"],
    contentType: json["content_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "subtitle": subtitle,
    "date": date,
    "duration": duration,
    "image": image,
    "type": type,
    "content_type": contentType,
  };
}
