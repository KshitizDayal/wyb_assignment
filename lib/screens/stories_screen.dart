import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:video_player/video_player.dart';
import 'package:wyb_assignment/model/story_data_model.dart';
import 'package:wyb_assignment/screens/json_data.dart';
import 'package:wyb_ds/wyb_ds.dart';

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
  VideoPlayerController? _videoPlayerController;
  VideoPlayerController? _nextVideoPlayerController;

  @override
  void initState() {
    super.initState();
    storiesdata = storyFromJson(jsonData);
    _loadStory();
  }

  void _loadStory() {
    _initializeVideoPlayer(
        storiesdata![currentStoryIndex].storyList![currentMediaIndex]);

    // Preload the next video if it exists
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
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl))
          ..initialize().then((_) {
            setState(() {
              _videoPlayerController?.play();
              _startAnimation();
            });
          });

    // Listen for when the video finishes playing
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
        VideoPlayerController.networkUrl(Uri.parse(videoUrl))
          ..initialize().then((_) {});
  }

  void _startAnimation() {
    _animationController?.dispose(); // Dispose the previous controller
    _animationController = AnimationController(
      vsync: this,
      duration:
          _videoPlayerController?.value.duration ?? const Duration(seconds: 5),
    )..forward();

    // Add listener to update UI when animation progresses
    _animationController?.addListener(() {
      setState(() {}); // Forces a rebuild to update progress bar
    });

    _animationController?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _onNextVideo(); // Handle the transition to the next video when animation completes
      }
    });
  }

  void _onNextVideo() {
    // If there are more videos in the current story, move to the next video
    if (currentMediaIndex <
        storiesdata![currentStoryIndex].storyList!.length - 1) {
      setState(() {
        currentMediaIndex++;

        // Switch to the preloaded video controller
        if (_nextVideoPlayerController != null &&
            _nextVideoPlayerController!.value.isInitialized) {
          _videoPlayerController = _nextVideoPlayerController;
          _nextVideoPlayerController = null; // Clear the next controller
          _videoPlayerController?.play();
          _startAnimation();
        } else {
          _initializeVideoPlayer(
              storiesdata![currentStoryIndex].storyList![currentMediaIndex]);
        }

        // Preload the next video if it exists
        if (currentMediaIndex + 1 <
            storiesdata![currentStoryIndex].storyList!.length) {
          _preloadNextVideo(storiesdata![currentStoryIndex]
              .storyList![currentMediaIndex + 1]);
        }
      });
    } else {
      // If no more videos in the current story, move to the next story
      _onNextStory();
    }
  }

  void _onPreviousVideo() {
    // If there are more videos in the current story, move to the previous video
    if (currentMediaIndex > 0) {
      setState(() {
        currentMediaIndex--;
        _initializeVideoPlayer(
            storiesdata![currentStoryIndex].storyList![currentMediaIndex]);
      });
    } else {
      // If no more videos in the current story, move to the previous story
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
    } else {
      // All stories completed
      _animationController?.dispose();
      _videoPlayerController?.dispose();
      _nextVideoPlayerController?.dispose();
      Navigator.pop(context);
    }
  }

  void _onPreviousStory() {
    if (currentMediaIndex > 0) {
      setState(() {
        currentMediaIndex--;
      });
      _restartStory();
    } else if (currentStoryIndex > 0) {
      setState(() {
        currentStoryIndex--;
        currentMediaIndex =
            storiesdata![currentStoryIndex].storyList!.length - 1;
      });
      _restartStory();
    }
  }

  void _restartStory() {
    _initializeVideoPlayer(
        storiesdata![currentStoryIndex].storyList![currentMediaIndex]);

    // Preload the next video if it exists
    if (currentMediaIndex + 1 <
        storiesdata![currentStoryIndex].storyList!.length) {
      _preloadNextVideo(
          storiesdata![currentStoryIndex].storyList![currentMediaIndex + 1]);
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _videoPlayerController?.dispose();
    _nextVideoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: (details) {
          final screenWidth = MediaQuery.of(context).size.width;
          final screenHeight = MediaQuery.of(context).size.height;

          // Tap on the left side for previous video
          if (details.globalPosition.dx < screenWidth / 3) {
            if (details.globalPosition.dy > screenHeight * 0.8) {
              _onPreviousVideo(); // Tapping lower left for the previous video
            } else {
              _onPreviousStory(); // Tapping upper left for the previous story
            }
          }
          // Tap on the right side for next video
          else {
            _onNextVideo();
          }
        },
        child: Stack(
          children: [
            _videoPlayerController != null &&
                    _videoPlayerController!.value.isInitialized
                ? VideoPlayer(_videoPlayerController!)
                : const Center(
                    child:
                        CircularProgressIndicator()), // Show a loading indicator until the video is ready
            SafeArea(
              child: Column(
                children: [
                  _animationController != null
                      ? _buildProgressBar()
                      : const SizedBox
                          .shrink(), // Show progress bar only if animationController is initialized
                  _buildStoryHeader(),
                  // Add profile list at the bottom
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildProfileList(),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: const EdgeInsets.all(4).copyWith(left: 16),
                child: Text(
                  storiesdata![currentStoryIndex].description ?? "",
                  style: WybFonts.normal14.copyWith(color: WybColor.white),
                ),
              ),
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
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: LinearProgressIndicator(
              value: index < currentMediaIndex
                  ? 1
                  : index == currentMediaIndex
                      ? _animationController?.value ?? 0
                      : 0,
              valueColor: const AlwaysStoppedAnimation(Colors.white),
              backgroundColor: Colors.white38,
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
            onTap: () => GoRouter.of(context).pop(),
            child: const Icon(
              Icons.clear,
              color: WybColor.white,
            ),
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
            },
            child: Container(
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
                backgroundImage:
                    CachedNetworkImageProvider(storiesdata![index].profilePic!),
              ),
            ),
          );
        },
      ),
    );
  }
}
