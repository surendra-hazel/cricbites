import 'package:Cricbites/data/api_service/api_service.dart';
import 'package:Cricbites/features/shorts/data/modal/shorts_list_modal.dart';
import 'package:get/get.dart';

class ShortsController extends GetxController {
  final ApiService _apiService = ApiService();
  var videos = <YouTubeShorts>[].obs;
  var nextPageToken = "".obs;
  var isLoading = false.obs;
  // final RxList<ReelModel> reels = <ReelModel>[].obs;
  Future<void> loadVideos({String? pageToken}) async {
    try {
      isLoading(true);
      final response = await _apiService.fetchYoutubeVideos(pageToken: pageToken);

      if (pageToken == null) {
        videos.assignAll(response.items ?? []);
        // for(var video in videos){
        //   reels.add(ReelModel(
        //     "https://youtube.com/shorts/${video.id!.videoId!}",
        //     video.snippet!.channelTitle!,
        //     // reelDescription: '${video.snippet!.title}',
        //     // musicName: 'Match Anthem',
        //     // likeCount: 2000,
        //     isLiked: false,
        //     profileUrl: video.snippet!.thumbnails!.medium!.url!,
        //   ));
        // }
      } else {
        videos.addAll(response.items ?? []);
        // for(var video in videos){
        //   reels.add(ReelModel(
        //     "https://youtube.com/shorts/${video.id!.videoId!}",
        //     video.snippet!.channelTitle!,
        //     // reelDescription: '${video.snippet!.title}',
        //     // musicName: 'Match Anthem',
        //     // likeCount: 2000,
        //     isLiked: false,
        //     profileUrl: video.snippet!.thumbnails!.medium!.url!,
        //   ));
        // }
      }
      nextPageToken.value = response.nextPageToken ?? "";
    } finally {
      isLoading(false);
    }
  }

  void loadMore() {
    if (nextPageToken.isNotEmpty) {
      loadVideos(pageToken: nextPageToken.value);
    }
  }
}
