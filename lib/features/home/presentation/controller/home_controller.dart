import 'package:Cricbites/data/api_service/api_service.dart';
import 'package:Cricbites/features/home/presentation/modal/home_modal.dart';
import 'package:Cricbites/widgets/common_app_toast.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  RxList<LiveMatch>  liveMatches = <LiveMatch>[].obs;
  RxList<MatchFilter>  tabs = <MatchFilter>[].obs;
  RxList<CricketStory> cricketStories = <CricketStory>[].obs;
  RxList<CricketStory> latestNews = <CricketStory>[].obs;
  RxList<CurrentSery> currentSeries = <CurrentSery>[].obs;
  // var latestNews = [].obs;
  Rx<FeaturedPlayer> featuredPlayer = FeaturedPlayer().obs;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  void fetchHomeData() async {
    try {
      isLoading(true);

      final result = await _apiService.getHomeData();

      if (result["status"] == 1) {
        final homePageData = HomePageModal.fromJson(result);
        tabs.value = homePageData.data?.data?.matchFilters ?? [];
        liveMatches.value = homePageData.data?.data?.liveMatches ?? [];
        cricketStories.value = homePageData.data?.data?.cricketStories ?? [];
        latestNews.value = homePageData.data?.data?.latestNews ?? [];
        currentSeries.value = homePageData.data?.data?.currentSeries ?? [];
        featuredPlayer.value = homePageData.data?.data?.featuredPlayer ?? FeaturedPlayer();
      }
    } catch (e) {
      AppToast.showError("Something went wrong. Please try again!");
    } finally {
      isLoading(false);
    }
  }

}
