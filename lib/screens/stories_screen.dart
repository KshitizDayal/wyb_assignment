import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:wyb_assignment/model/story_data_model.dart';
import 'package:wyb_ds/wyb_ds.dart';

import 'json_data.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({super.key});

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen>
    with TickerProviderStateMixin {
  List<StoryDataModel>? storiesdata;
  int currentStoryIndex = 0;
  int currentMediaIndex = 0;
  AnimationController? _animationController;
  CachedVideoPlayerPlusController? _videoPlayerController;
  CachedVideoPlayerPlusController? _nextVideoPlayerController;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    storiesdata = storyFromJson(jsonData);
    _loadStory();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _centerCurrentStory();
    });
  }

  void _centerCurrentStory() {
    if (_scrollController.hasClients && storiesdata != null) {
      double itemWidth = 100.0;

      double screenWidth = MediaQuery.of(context).size.width;

      double scrollPosition =
          (itemWidth * currentStoryIndex) - (screenWidth / 2 - itemWidth / 2);

      scrollPosition = scrollPosition.clamp(
        0.0,
        _scrollController.position.maxScrollExtent,
      );

      _scrollController.animateTo(
        scrollPosition,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void didUpdateWidget(covariant StoriesScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _centerCurrentStory();
    });
  }

  void _loadStory() {
    _initializeVideoPlayer(
        storiesdata![currentStoryIndex].storyList![currentMediaIndex]);

    if (currentMediaIndex + 1 <
        storiesdata![currentStoryIndex].storyList!.length) {
      _preloadNextVideo(
          storiesdata![currentStoryIndex].storyList![currentMediaIndex + 1]);
    }
  }

  void _initializeVideoPlayer(String videoUrl) {
    final lastVideoController = _videoPlayerController;
    if (lastVideoController != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        lastVideoController.dispose();
      });
    }
    _videoPlayerController = CachedVideoPlayerPlusController.networkUrl(
      Uri.parse(videoUrl),
    )..initialize().then((_) {
        setState(() {
          _videoPlayerController?.play();
          _startAnimation();
        });
      });

    _videoPlayerController?.addListener(() {
      if (_videoPlayerController!.value.isInitialized &&
          !_videoPlayerController!.value.isPlaying &&
          _videoPlayerController!.value.position >=
              _videoPlayerController!.value.duration) {
        _onNextVideo();
      }
    });
  }

  void _preloadNextVideo(String videoUrl) {
    _nextVideoPlayerController?.dispose();
    _nextVideoPlayerController =
        CachedVideoPlayerPlusController.networkUrl(Uri.parse(videoUrl))
          ..initialize().then((_) {});
  }

  void _startAnimation() {
    _animationController?.dispose();
    _animationController = AnimationController(
      vsync: this,
      duration:
          _videoPlayerController?.value.duration ?? const Duration(seconds: 5),
    )..forward();

    _animationController?.addListener(() {
      setState(() {});
    });

    _animationController?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _onNextVideo();
      }
    });
  }

  void _onNextVideo() {
    if (currentMediaIndex <
        storiesdata![currentStoryIndex].storyList!.length - 1) {
      setState(() {
        currentMediaIndex++;
        if (_nextVideoPlayerController != null &&
            _nextVideoPlayerController!.value.isInitialized) {
          _videoPlayerController = _nextVideoPlayerController;
          _nextVideoPlayerController = null;
          _videoPlayerController?.play();
          _startAnimation();
        } else {
          _initializeVideoPlayer(
              storiesdata![currentStoryIndex].storyList![currentMediaIndex]);
        }

        if (currentMediaIndex + 1 <
            storiesdata![currentStoryIndex].storyList!.length) {
          _preloadNextVideo(storiesdata![currentStoryIndex]
              .storyList![currentMediaIndex + 1]);
        }
      });
    } else {
      _onNextStory();
    }
  }

  void _onPreviousVideo() {
    if (currentMediaIndex > 0) {
      setState(() {
        currentMediaIndex--;
        _initializeVideoPlayer(
            storiesdata![currentStoryIndex].storyList![currentMediaIndex]);
      });
    } else {
      _onPreviousStory();
    }
  }

  void _onNextStory() {
    if (currentStoryIndex < storiesdata!.length - 1) {
      setState(() {
        currentStoryIndex++;
        currentMediaIndex = 0;
      });
      _restartStory();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _centerCurrentStory();
      });
    } else {
      _animationController?.dispose();
      _videoPlayerController?.dispose();
      _nextVideoPlayerController?.dispose();
      Navigator.pop(context);
    }
  }

  void _onPreviousStory() {
    if (currentStoryIndex > 0) {
      setState(() {
        currentStoryIndex--;
        currentMediaIndex = 0;
      });
      _restartStory();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _centerCurrentStory();
      });
    }
  }

  void _restartStory() {
    _initializeVideoPlayer(
        storiesdata![currentStoryIndex].storyList![currentMediaIndex]);

    if (currentMediaIndex + 1 <
        storiesdata![currentStoryIndex].storyList!.length) {
      _preloadNextVideo(
          storiesdata![currentStoryIndex].storyList![currentMediaIndex + 1]);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController?.dispose();
    _videoPlayerController?.dispose();
    _nextVideoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx < 0) {
            _onNextStory();
          } else if (details.velocity.pixelsPerSecond.dx > 0) {
            _onPreviousStory();
          }
        },
        onTapUp: (details) {
          final screenWidth = MediaQuery.of(context).size.width;
          final tapPosition = details.globalPosition.dx;

          if (tapPosition < screenWidth / 3) {
            _onPreviousVideo();
          } else if (tapPosition > screenWidth * 2 / 3) {
            _onNextVideo();
          } else {
            _onNextVideo();
          }
        },
        child: Stack(
          children: [
            _videoPlayerController != null &&
                    _videoPlayerController!.value.isInitialized
                ? CachedVideoPlayerPlus(_videoPlayerController!)
                : const Center(child: CircularProgressIndicator()),
            SafeArea(
              child: Column(
                children: [
                  _animationController != null
                      ? _buildProgressBar()
                      : const SizedBox.shrink(),
                  _buildStoryHeader(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildProfileList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Row(
      children: List.generate(
        storiesdata![currentStoryIndex].storyList!.length,
        (index) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: LinearProgressIndicator(
              value: index < currentMediaIndex
                  ? 1
                  : index == currentMediaIndex
                      ? _animationController?.value ?? 0
                      : 0,
              valueColor: const AlwaysStoppedAnimation(Colors.white),
              backgroundColor: WybColor.white.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStoryHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: storiesdata![currentStoryIndex].profilePic!,
                imageBuilder: (context, imageProvider) => Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                storiesdata![currentStoryIndex].name!,
                style: WybFonts.bold14.copyWith(color: WybColor.white),
              ),
              const SizedBox(width: 4),
              Text(
                storiesdata![currentStoryIndex].postedTime!,
                style: WybFonts.bold14.copyWith(color: WybColor.white),
              ),
            ],
          ),
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.clear, color: WybColor.white),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileList() {
    return Container(
      margin: const EdgeInsets.only(bottom: 28),
      height: 100,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: storiesdata!.length,
        itemBuilder: (context, index) {
          bool isActive = index == currentStoryIndex;

          return GestureDetector(
            onTap: () {
              setState(() {
                currentStoryIndex = index;
                currentMediaIndex = 0;
                _restartStory();
              });
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _centerCurrentStory();
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: isActive
                        ? const GradientBoxBorder(
                            width: 3,
                            gradient: LinearGradient(colors: [
                              WybColor.secondary,
                              WybColor.tertiary,
                              WybColor.quaternary,
                            ]),
                          )
                        : Border.all(width: 0),
                  ),
                  child: CircleAvatar(
                    radius: isActive ? 50 : 30,
                    backgroundImage: CachedNetworkImageProvider(
                        storiesdata![index].profilePic!),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 0,
                  child: isActive
                      ? Text(
                          storiesdata![index].emoji ?? "",
                          style: const TextStyle(fontSize: 24),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
