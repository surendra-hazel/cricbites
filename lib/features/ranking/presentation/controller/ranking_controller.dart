import 'package:Cricbites/core/constants/app_prefs.dart';
import 'package:Cricbites/data/api_service/api_service.dart';
import 'package:Cricbites/features/ranking/data/modal/icc_ranking_modal.dart';
import 'package:Cricbites/widgets/common_app_toast.dart';
import 'package:get/get.dart';

class RankingController extends GetxController {
  var isLoading = false.obs;
  final ApiService _apiService = ApiService();

  /// Men
  RxList<AllRoundersOdi> mansOdisBatting = <AllRoundersOdi>[].obs;
  RxList<AllRoundersOdi> manTestsBatting = <AllRoundersOdi>[].obs;
  RxList<AllRoundersOdi> manT20SBatting = <AllRoundersOdi>[].obs;

  RxList<AllRoundersOdi> mansOdisBowlers = <AllRoundersOdi>[].obs;
  RxList<AllRoundersOdi> manTestsBowlers = <AllRoundersOdi>[].obs;
  RxList<AllRoundersOdi> manT20SBowlers = <AllRoundersOdi>[].obs;

  RxList<AllRoundersOdi> mansOdisAllRounder = <AllRoundersOdi>[].obs;
  RxList<AllRoundersOdi> manTestsAllRounder = <AllRoundersOdi>[].obs;
  RxList<AllRoundersOdi> manT20SAllRounder = <AllRoundersOdi>[].obs;

  /// Women
  RxList<AllRoundersOdi> womenOdisBatting = <AllRoundersOdi>[].obs;
  RxList<AllRoundersOdi> womenTestsBatting = <AllRoundersOdi>[].obs;
  RxList<AllRoundersOdi> womenT20SBatting = <AllRoundersOdi>[].obs;

  RxList<AllRoundersOdi> womenOdisBowlers = <AllRoundersOdi>[].obs;
  RxList<AllRoundersOdi> womenTestsBowlers = <AllRoundersOdi>[].obs;
  RxList<AllRoundersOdi> womenT20SBowlers = <AllRoundersOdi>[].obs;

  RxList<AllRoundersOdi> womenOdisAllRounder = <AllRoundersOdi>[].obs;
  RxList<AllRoundersOdi> womenTestsAllRounder = <AllRoundersOdi>[].obs;
  RxList<AllRoundersOdi> womenT20SAllRounder = <AllRoundersOdi>[].obs;
  RxList<TeamsOdi> manTeamsOdis = <TeamsOdi>[].obs;
  RxList<TeamsOdi> manTeamsTests = <TeamsOdi>[].obs;
  RxList<TeamsOdi> manTeamsT20S = <TeamsOdi>[].obs;
  RxList<TeamsOdi> womenTeamsOdis = <TeamsOdi>[].obs;
  RxList<TeamsOdi> womenTeamsTests = <TeamsOdi>[].obs;
  RxList<TeamsOdi> womenTeamsT20S = <TeamsOdi>[].obs;
  // RxList<AllRoundersOdi> dataList = <AllRoundersOdi>[].obs;
  RxList<dynamic> dataList = <dynamic>[].obs;

  Future<void> fetchRanking() async {
    try {
      isLoading.value = true;
      final userId = await AppPrefs.getUserId();
      if (userId == null) return;

      final result = await _apiService.rankingListMethod();
      if (result.status == "ok") {
        // Men Batting
        mansOdisBatting.value = result.response?.ranks?.batsmen?.odis ?? [];
        manTestsBatting.value = result.response?.ranks?.batsmen?.tests ?? [];
        manT20SBatting.value = result.response?.ranks?.batsmen?.t20S ?? [];

        // Men Bowlers
        mansOdisBowlers.value = result.response?.ranks?.bowlers?.odis ?? [];
        manTestsBowlers.value = result.response?.ranks?.bowlers?.tests ?? [];
        manT20SBowlers.value = result.response?.ranks?.bowlers?.t20S ?? [];

        // Men All Rounder
        mansOdisAllRounder.value = result.response?.ranks?.allRounders?.odis ?? [];
        manTestsAllRounder.value = result.response?.ranks?.allRounders?.tests ?? [];
        manT20SAllRounder.value = result.response?.ranks?.allRounders?.t20S ?? [];

        // Women Batting
        womenOdisBatting.value = result.response?.womenRanks?.batsmen?.odis ?? [];
        womenTestsBatting.value = result.response?.womenRanks?.batsmen?.tests ?? [];
        womenT20SBatting.value = result.response?.womenRanks?.batsmen?.t20S ?? [];

        // Women Bowlers
        womenOdisBowlers.value = result.response?.womenRanks?.bowlers?.odis ?? [];
        womenTestsBowlers.value = result.response?.womenRanks?.bowlers?.tests ?? [];
        womenT20SBowlers.value = result.response?.womenRanks?.bowlers?.t20S ?? [];

        // Women All Rounder
        womenOdisAllRounder.value = result.response?.womenRanks?.allRounders?.odis ?? [];
        womenTestsAllRounder.value = result.response?.womenRanks?.allRounders?.tests ?? [];
        womenT20SAllRounder.value = result.response?.womenRanks?.allRounders?.t20S ?? [];

        manTeamsOdis.value = result.response?.ranks?.teams?.odis ?? [];
        womenTeamsOdis.value = result.response?.womenRanks?.teams?.odis ?? [];
        manTeamsTests.value = result.response?.ranks?.teams?.tests ?? [];
        womenTeamsTests.value = result.response?.womenRanks?.teams?.tests ?? [];
        manTeamsT20S.value = result.response?.ranks?.teams?.t20S ?? [];
        womenTeamsT20S.value = result.response?.womenRanks?.teams?.t20S ?? [];

        dataList.assignAll(getCurrentList());
      } else {
        clearAll();
      }
    } catch (e) {
      AppToast.showError("Something went wrong, Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  void clearAll() {
    mansOdisBatting.clear();
    manTestsBatting.clear();
    manT20SBatting.clear();
    womenOdisBatting.clear();
    womenTestsBatting.clear();
    womenT20SBatting.clear();

    mansOdisBowlers.clear();
    manTestsBowlers.clear();
    manT20SBowlers.clear();
    womenOdisBowlers.clear();
    womenTestsBowlers.clear();
    womenT20SBowlers.clear();

    mansOdisAllRounder.clear();
    manTestsAllRounder.clear();
    manT20SAllRounder.clear();
    womenOdisAllRounder.clear();
    womenTestsAllRounder.clear();
    womenT20SAllRounder.clear();
  }

  Rx<int> selectedGender = 0.obs;
  Rx<int> selectedCategory = 0.obs;
  Rx<int> selectedFormat = 0.obs;

  RxList<dynamic> getCurrentList() {
    if (selectedGender.value == 0) {
      if (selectedCategory.value == 0) {
        if (selectedFormat.value == 0) return manTeamsTests;
        if (selectedFormat.value == 1) return manTeamsOdis;
        return manTeamsT20S;
      } else if (selectedCategory.value == 1) {
        if (selectedFormat.value == 0) return manTestsBatting;
        if (selectedFormat.value == 1) return mansOdisBatting;
        return manT20SBatting;
      } else if (selectedCategory.value == 2) {
        if (selectedFormat.value == 0) return manTestsBowlers;
        if (selectedFormat.value == 1) return mansOdisBowlers;
        return manT20SBowlers;
      } else if (selectedCategory.value == 3) {
        if (selectedFormat.value == 0) return manTestsAllRounder;
        if (selectedFormat.value == 1) return mansOdisAllRounder;
        return manT20SAllRounder;
      }
    }
    else {
      if (selectedCategory.value == 0) {
        if (selectedFormat.value == 0) return womenTeamsTests;
        if (selectedFormat.value == 1) return womenTeamsOdis;
        return womenTeamsT20S;
      } else if (selectedCategory.value == 1) {
        if (selectedFormat.value == 0) return womenTestsBatting;
        if (selectedFormat.value == 1) return womenOdisBatting;
        return womenT20SBatting;
      } else if (selectedCategory.value == 2) {
        if (selectedFormat.value == 0) return womenTestsBowlers;
        if (selectedFormat.value == 1) return womenOdisBowlers;
        return womenT20SBowlers;
      } else if (selectedCategory.value == 3) {
        if (selectedFormat.value == 0) return womenTestsAllRounder;
        if (selectedFormat.value == 1) return womenOdisAllRounder;
        return womenT20SAllRounder;
      }
    }

    return <dynamic>[].obs;
  }


  void changeGender(int index) {
    selectedGender.value = index;
    selectedCategory.value = 0;
    selectedFormat.value = 0;
    dataList.assignAll(getCurrentList());
  }

  void changeCategory(int index) {
    selectedCategory.value = index;
    selectedFormat.value = 0;
    dataList.assignAll(getCurrentList());
  }

  void changeFormat(int index) {
    selectedFormat.value = index;
    dataList.assignAll(getCurrentList());
  }


  
}
