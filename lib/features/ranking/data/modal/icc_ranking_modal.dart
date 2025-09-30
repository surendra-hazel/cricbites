// To parse this JSON data, do
//
//     final iccRankingListModal = iccRankingListModalFromJson(jsonString);

import 'dart:convert';

IccRankingListModal iccRankingListModalFromJson(String str) => IccRankingListModal.fromJson(json.decode(str));

String iccRankingListModalToJson(IccRankingListModal data) => json.encode(data.toJson());

class IccRankingListModal {
  String? status;
  Response? response;

  IccRankingListModal({
    this.status,
    this.response,
  });

  factory IccRankingListModal.fromJson(Map<String, dynamic> json) => IccRankingListModal(
    status: json["status"],
    response: json["response"] == null ? null : Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "response": response?.toJson(),
  };
}

class Response {
  Ranks? ranks;
  Ranks? womenRanks;
  Groups? groups;
  Formats? formats;
  List<TestChampionshipRanking>? testChampionshipRanking;

  Response({
    this.ranks,
    this.womenRanks,
    this.groups,
    this.formats,
    this.testChampionshipRanking,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    ranks: json["ranks"] == null ? null : Ranks.fromJson(json["ranks"]),
    womenRanks: json["women_ranks"] == null ? null : Ranks.fromJson(json["women_ranks"]),
    groups: json["groups"] == null ? null : Groups.fromJson(json["groups"]),
    formats: json["formats"] == null ? null : Formats.fromJson(json["formats"]),
    testChampionshipRanking: json["test_championship_ranking"] == null ? [] : List<TestChampionshipRanking>.from(json["test_championship_ranking"]!.map((x) => TestChampionshipRanking.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ranks": ranks?.toJson(),
    "women_ranks": womenRanks?.toJson(),
    "groups": groups?.toJson(),
    "formats": formats?.toJson(),
    "test_championship_ranking": testChampionshipRanking == null ? [] : List<dynamic>.from(testChampionshipRanking!.map((x) => x.toJson())),
  };
}

class Formats {
  String? tests;
  String? odis;
  String? t20S;

  Formats({
    this.tests,
    this.odis,
    this.t20S,
  });

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
    tests: json["tests"],
    odis: json["odis"],
    t20S: json["t20s"],
  );

  Map<String, dynamic> toJson() => {
    "tests": tests,
    "odis": odis,
    "t20s": t20S,
  };
}

class Groups {
  String? teams;
  String? batsmen;
  String? bowlers;
  String? allRounders;

  Groups({
    this.teams,
    this.batsmen,
    this.bowlers,
    this.allRounders,
  });

  factory Groups.fromJson(Map<String, dynamic> json) => Groups(
    teams: json["teams"],
    batsmen: json["batsmen"],
    bowlers: json["bowlers"],
    allRounders: json["all-rounders"],
  );

  Map<String, dynamic> toJson() => {
    "teams": teams,
    "batsmen": batsmen,
    "bowlers": bowlers,
    "all-rounders": allRounders,
  };
}

class Ranks {
  RanksAllRounders? batsmen;
  RanksAllRounders? bowlers;
  RanksAllRounders? allRounders;
  RanksTeams? teams;

  Ranks({
    this.batsmen,
    this.bowlers,
    this.allRounders,
    this.teams,
  });

  factory Ranks.fromJson(Map<String, dynamic> json) => Ranks(
    batsmen: json["batsmen"] == null ? null : RanksAllRounders.fromJson(json["batsmen"]),
    bowlers: json["bowlers"] == null ? null : RanksAllRounders.fromJson(json["bowlers"]),
    allRounders: json["all-rounders"] == null ? null : RanksAllRounders.fromJson(json["all-rounders"]),
    teams: json["teams"] == null ? null : RanksTeams.fromJson(json["teams"]),
  );

  Map<String, dynamic> toJson() => {
    "batsmen": batsmen?.toJson(),
    "bowlers": bowlers?.toJson(),
    "all-rounders": allRounders?.toJson(),
    "teams": teams?.toJson(),
  };
}

class RanksAllRounders {
  List<AllRoundersOdi>? odis;
  List<AllRoundersOdi>? tests;
  List<AllRoundersOdi>? t20S;

  RanksAllRounders({
    this.odis,
    this.tests,
    this.t20S,
  });

  factory RanksAllRounders.fromJson(Map<String, dynamic> json) => RanksAllRounders(
    odis: json["odis"] == null ? [] : List<AllRoundersOdi>.from(json["odis"]!.map((x) => AllRoundersOdi.fromJson(x))),
    tests: json["tests"] == null ? [] : List<AllRoundersOdi>.from(json["tests"]!.map((x) => AllRoundersOdi.fromJson(x))),
    t20S: json["t20s"] == null ? [] : List<AllRoundersOdi>.from(json["t20s"]!.map((x) => AllRoundersOdi.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "odis": odis == null ? [] : List<dynamic>.from(odis!.map((x) => x.toJson())),
    "tests": tests == null ? [] : List<dynamic>.from(tests!.map((x) => x.toJson())),
    "t20s": t20S == null ? [] : List<dynamic>.from(t20S!.map((x) => x.toJson())),
  };
}

class AllRoundersOdi {
  String? rank;
  String? pid;
  String? player;
  String? team;
  String? rating;
  String? careerbestrating;
  String? teamId;

  AllRoundersOdi({
    this.rank,
    this.pid,
    this.player,
    this.team,
    this.rating,
    this.careerbestrating,
    this.teamId,
  });

  factory AllRoundersOdi.fromJson(Map<String, dynamic> json) => AllRoundersOdi(
    rank: json["rank"],
    pid: json["pid"],
    player: json["player"],
    team: json["team"],
    rating: json["rating"],
    careerbestrating: json["careerbestrating"],
    teamId: json["team_id"],
  );

  Map<String, dynamic> toJson() => {
    "rank": rank,
    "pid": pid,
    "player": player,
    "team": team,
    "rating": rating,
    "careerbestrating": careerbestrating,
    "team_id": teamId,
  };
}

class RanksTeams {
  List<TeamsOdi>? odis;
  List<TeamsOdi>? tests;
  List<TeamsOdi>? t20S;

  RanksTeams({
    this.odis,
    this.tests,
    this.t20S,
  });

  factory RanksTeams.fromJson(Map<String, dynamic> json) => RanksTeams(
    odis: json["odis"] == null ? [] : List<TeamsOdi>.from(json["odis"]!.map((x) => TeamsOdi.fromJson(x))),
    tests: json["tests"] == null ? [] : List<TeamsOdi>.from(json["tests"]!.map((x) => TeamsOdi.fromJson(x))),
    t20S: json["t20s"] == null ? [] : List<TeamsOdi>.from(json["t20s"]!.map((x) => TeamsOdi.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "odis": odis == null ? [] : List<dynamic>.from(odis!.map((x) => x.toJson())),
    "tests": tests == null ? [] : List<dynamic>.from(tests!.map((x) => x.toJson())),
    "t20s": t20S == null ? [] : List<dynamic>.from(t20S!.map((x) => x.toJson())),
  };
}

class TeamsOdi {
  String? rank;
  String? tid;
  String? team;
  String? points;
  String? rating;
  String? logoUrl;
  String? matches;

  TeamsOdi({
    this.rank,
    this.tid,
    this.team,
    this.points,
    this.rating,
    this.logoUrl,
    this.matches,
  });

  factory TeamsOdi.fromJson(Map<String, dynamic> json) => TeamsOdi(
    rank: json["rank"],
    tid: json["tid"],
    team: json["team"],
    points: json["points"],
    rating: json["rating"],
    logoUrl: json["logo_url"],
    matches: json["matches"],
  );

  Map<String, dynamic> toJson() => {
    "rank": rank,
    "tid": tid,
    "team": team,
    "points": points,
    "rating": rating,
    "logo_url": logoUrl,
    "matches": matches,
  };
}

class TestChampionshipRanking {
  String? teamId;
  String? teamName;
  String? rank;
  String? qualified;
  String? totalMatch;
  String? win;
  String? loss;
  String? drawn;
  String? noresult;
  String? points;
  String? homeWin;
  String? awayWin;
  String? pct;

  TestChampionshipRanking({
    this.teamId,
    this.teamName,
    this.rank,
    this.qualified,
    this.totalMatch,
    this.win,
    this.loss,
    this.drawn,
    this.noresult,
    this.points,
    this.homeWin,
    this.awayWin,
    this.pct,
  });

  factory TestChampionshipRanking.fromJson(Map<String, dynamic> json) => TestChampionshipRanking(
    teamId: json["team_id"],
    teamName: json["team_name"],
    rank: json["rank"],
    qualified: json["qualified"],
    totalMatch: json["total_match"],
    win: json["win"],
    loss: json["loss"],
    drawn: json["drawn"],
    noresult: json["noresult"],
    points: json["points"],
    homeWin: json["home_win"],
    awayWin: json["away_win"],
    pct: json["pct"],
  );

  Map<String, dynamic> toJson() => {
    "team_id": teamId,
    "team_name": teamName,
    "rank": rank,
    "qualified": qualified,
    "total_match": totalMatch,
    "win": win,
    "loss": loss,
    "drawn": drawn,
    "noresult": noresult,
    "points": points,
    "home_win": homeWin,
    "away_win": awayWin,
    "pct": pct,
  };
}