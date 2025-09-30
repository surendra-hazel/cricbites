/*
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reels_viewer/reels_viewer.dart';
import 'package:Cricbites/features/shorts/presentation/controller/shorts_controller.dart';

class ShortsScreen extends StatefulWidget {
  const ShortsScreen({super.key});

  @override
  State<ShortsScreen> createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> {
  final ShortsController controller = Get.put(ShortsController());

  @override
  void initState() {
    super.initState();
    controller.loadVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Obx(() {
          if (controller.isLoading.value && controller.reels.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          if (controller.reels.isEmpty) {
            return const Center(
              child: Text(
                "No Shorts Found",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ReelsViewer(
            reelsList: controller.reels,
            showAppbar: false,
            showVerifiedTick: false,
            showProgressIndicator: true,
            onShare: (url) => log('Share: $url'),
            onLike: (url) => log('Like: $url'),
            onFollow: () => log('Follow clicked'),
            onComment: (comment) => log('Comment: $comment'),
            onClickMoreBtn: () => log('More pressed'),
            onClickBackArrow: () => Navigator.of(context).maybePop(),
            onIndexChanged: (index) {
              if (index == controller.reels.length - 2 &&
                  controller.nextPageToken.isNotEmpty) {
                controller.loadMore();
              }
            },
          );
        }),
      ),
    );
  }
}
*/
import 'package:Cricbites/core/constants/app_colors.dart';
import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:Cricbites/features/shorts/presentation/controller/shorts_controller.dart';
import 'package:Cricbites/features/shorts/data/modal/shorts_list_modal.dart';

class ShortsScreen extends StatefulWidget {
  const ShortsScreen({super.key});

  @override
  State<ShortsScreen> createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> {
  final controller = Get.put(ShortsController());
  final PageController _pageController = PageController();

  YoutubePlayerController? _ytController;
  int _currentIndex = 0;
  bool _isMuted = false;
  bool _isPlaying = true;
  final RxSet<int> likedVideos = <int>{}.obs;

  @override
  void initState() {
    super.initState();
    controller.loadVideos();
  }

  void _loadVideo(String videoId) {
    _ytController?.dispose();
    print("******************************* $videoId");
    print("https://youtube.com/shorts/$videoId");
    final newController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: _isMuted,
        loop: true,
        forceHD: true,
        hideControls: true,
        controlsVisibleAtStart: false,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _ytController = newController;
          _isPlaying = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _ytController?.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CommonAppBar(titleText: "Shorts"),
      body: SafeArea(
        bottom: true,
        child: Obx(() {
          if (controller.isLoading.value && controller.videos.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          if (controller.videos.isEmpty) {
            return const Center(
              child: Text(
                "No Shorts Found",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final List<YouTubeShorts> videos = controller.videos;

          if (_ytController == null && videos.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _loadVideo(videos[0].id?.videoId ?? "");
            });
          }

          return PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: videos.length,
            onPageChanged: (index) {
              _currentIndex = index;
              final videoId = videos[index].id?.videoId ?? "";
              if (videoId.isNotEmpty) {
                _loadVideo(videoId);
              }
              if (index == videos.length - 2 &&
                  controller.nextPageToken.isNotEmpty) {
                controller.loadMore();
              }
            },
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  // ✅ Fullscreen video
                  Center(
                    child: _currentIndex == index && _ytController != null
                        ? YoutubePlayerBuilder(
                      player: YoutubePlayer(
                        controller: _ytController!,
                        aspectRatio: 9 / 16,
                        showVideoProgressIndicator: true,
                      ),
                      builder: (context, player) {
                        return SizedBox.expand(child: player);
                      },
                    )
                        : const SizedBox.shrink(),
                  ),

                  // ✅ Overlay Controls
                  Positioned(
                    child: GestureDetector(
                      onTap: () {
                        if (_ytController != null) {
                          if (_isPlaying) {
                            _ytController!.pause();
                          } else {
                            _ytController!.play();
                          }
                          setState(() {
                            _isPlaying = !_isPlaying;
                          });
                        }
                      },
                      child: Center(
                        child: !_isPlaying
                            ? const Icon(
                          Icons.play_arrow,
                          color: Colors.red,
                          size: 250,
                        )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ),

                  // ✅ Action Buttons (right side)
                  Positioned(
                    right: 12,
                    bottom: 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(() {
                          final isLiked = likedVideos.contains(index);
                          return IconButton(
                            icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked ? Colors.red : Colors.white,
                              size: 32,
                            ),
                            onPressed: () {
                              if (isLiked) {
                                likedVideos.remove(index);
                              } else {
                                likedVideos.add(index);
                              }
                            },
                          );
                        }),
                        const SizedBox(height: 20),
                        // IconButton(
                        //   icon: const Icon(Icons.comment,
                        //       color: Colors.white, size: 32),
                        //   onPressed: () {
                        //     // TODO: open comments bottomsheet
                        //   },
                        // ),
                        // const SizedBox(height: 20),
                        // IconButton(
                        //   icon: const Icon(Icons.share,
                        //       color: Colors.white, size: 32),
                        //   onPressed: () {
                        //     // TODO: share logic
                        //   },
                        // ),
                        // const SizedBox(height: 20),
                        IconButton(
                          icon: Icon(
                            _isMuted ? Icons.volume_off : Icons.volume_up,
                            color: Colors.white,
                            size: 32,
                          ),
                          onPressed: () {
                            if (_ytController != null) {
                              if (_isMuted) {
                                _ytController!.unMute();
                              } else {
                                _ytController!.mute();
                              }
                              setState(() {
                                _isMuted = !_isMuted;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  // ✅ Bottom overlay info
                  // Container(
                  //   padding: const EdgeInsets.all(12),
                  //   margin: const EdgeInsets.only(bottom: 80),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         video.snippet?.title ?? "",
                  //         style: const TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //         maxLines: 2,
                  //         overflow: TextOverflow.ellipsis,
                  //       ),
                  //       const SizedBox(height: 5),
                  //       Text(
                  //         video.snippet?.description ?? "",
                  //         style: const TextStyle(
                  //           color: Colors.white70,
                  //           fontSize: 12,
                  //         ),
                  //         maxLines: 2,
                  //         overflow: TextOverflow.ellipsis,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}