final jsonData = [
  {
    "name": "Sophie Carter",
    "profile_pic":
        "https://firebasestorage.googleapis.com/v0/b/wyb-assignment.appspot.com/o/persons%2Fperson_1.jpg?alt=media&token=9e44ee1b-2730-4a37-8e6d-e84f9bbf1ab1",
    "emoji": "😄",
    "description": "Nature is awesome",
    "story_list": [
      "https://firebasestorage.googleapis.com/v0/b/wyb-assignment.appspot.com/o/videos%2Fvideo_8.webm?alt=media&token=e1a3fa2f-2bf2-42b2-a1b0-ae32dba2f4a6"
    ],
    "posted_time": "1h"
  },
  {
    "name": "Liam Johnson",
    "profile_pic":
        "https://firebasestorage.googleapis.com/v0/b/wyb-assignment.appspot.com/o/persons%2Fperson_3.jpg?alt=media&token=986170ac-fb1c-4c5e-9262-fbcfcf2c6b2d",
    "emoji": "🙂",
    "description": "Awesomenees",
    "story_list": [
      "https://firebasestorage.googleapis.com/v0/b/wyb-assignment.appspot.com/o/videos%2Fvideo_3.webm?alt=media&token=8d3158f7-207f-4a68-88e9-d53a7f7cdc21",
      "https://firebasestorage.googleapis.com/v0/b/wyb-assignment.appspot.com/o/videos%2Fvideo_7.webm?alt=media&token=ced954a0-7997-49eb-a943-41532e411505",
      "https://firebasestorage.googleapis.com/v0/b/wyb-assignment.appspot.com/o/videos%2Fvideo_4.webm?alt=media&token=2e68c41e-0674-439b-baa4-73ba7c64bdc4"
    ],
    "posted_time": "47m"
  },
  {
    "name": "Isabella Martinez",
    "profile_pic":
        "https://firebasestorage.googleapis.com/v0/b/wyb-assignment.appspot.com/o/persons%2Fperson_2.jpg?alt=media&token=509e7b91-1b08-4385-affa-6157eb1185dc",
    "emoji": "😍",
    "description": "Hi",
    "story_list": [
      "https://firebasestorage.googleapis.com/v0/b/wyb-assignment.appspot.com/o/videos%2Fvideo_4.webm?alt=media&token=2e68c41e-0674-439b-baa4-73ba7c64bdc4"
    ],
    "posted_time": "1d"
  },
  {
    "name": "Ethan Thompson",
    "profile_pic":
        "https://firebasestorage.googleapis.com/v0/b/wyb-assignment.appspot.com/o/persons%2Fperson_4.jpg?alt=media&token=e9e896a9-0742-445b-bbc0-f9d18afe6bd0",
    "emoji": "😎",
    "description": "Hello",
    "story_list": [
      "https://firebasestorage.googleapis.com/v0/b/wyb-assignment.appspot.com/o/videos%2Fvideo_5.webm?alt=media&token=d8b8d4a5-5d53-4261-996f-a6f982e4f28d",
      "https://firebasestorage.googleapis.com/v0/b/wyb-assignment.appspot.com/o/videos%2Fvideo_6.webm?alt=media&token=0f3cd45f-6a1a-49dd-8471-3142bc3a4f8f",
      "https://firebasestorage.googleapis.com/v0/b/wyb-assignment.appspot.com/o/videos%2Fvideo_8.webm?alt=media&token=e1a3fa2f-2bf2-42b2-a1b0-ae32dba2f4a6"
    ],
    "posted_time": "15h"
  },
  {
    "name": "Robin",
    "profile_pic":
        "https://firebasestorage.googleapis.com/v0/b/wyb-assignment.appspot.com/o/persons%2Fperson_5.jpg?alt=media&token=5094fa4b-b473-4b15-bc25-53f9bd919dcf",
    "emoji": "🤩",
    "description": "Wassupe",
    "story_list": [
      "https://firebasestorage.googleapis.com/v0/b/wyb-assignment.appspot.com/o/videos%2Fvideo_6.webm?alt=media&token=0f3cd45f-6a1a-49dd-8471-3142bc3a4f8f"
    ],
    "posted_time": "7d"
  },
];




// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cached_video_player_plus/cached_video_player_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:gradient_borders/gradient_borders.dart';
// import 'package:wyb_assignment/model/story_data_model.dart';
// import 'package:wyb_assignment/screens/json_data.dart';
// import 'package:wyb_ds/wyb_ds.dart';

// class StoriesScreen extends StatefulWidget {
//   const StoriesScreen({super.key});

//   @override
//   State<StoriesScreen> createState() => _StoriesScreenState();
// }

// class _StoriesScreenState extends State<StoriesScreen>
//     with TickerProviderStateMixin {
//   List<StoryDataModel>? storiesdata;
//   int currentStoryIndex = 0;
//   int currentMediaIndex = 0;
//   AnimationController? _animationController;
//   CachedVideoPlayerPlusController? _videoPlayerController;
//   CachedVideoPlayerPlusController? _nextVideoPlayerController;

//   @override
//   void initState() {
//     super.initState();
//     storiesdata = storyFromJson(jsonData);
//     _loadStory();
//   }

//   void _loadStory() {
//     _initializeVideoPlayer(
//         storiesdata![currentStoryIndex].storyList![currentMediaIndex]);

//     // Preload the next video if it exists
//     if (currentMediaIndex + 1 <
//         storiesdata![currentStoryIndex].storyList!.length) {
//       _preloadNextVideo(
//           storiesdata![currentStoryIndex].storyList![currentMediaIndex + 1]);
//     }
//   }

//   void _initializeVideoPlayer(String videoUrl) {
//     final lastVideoController = _videoPlayerController;
//     if (lastVideoController != null) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         lastVideoController.dispose();
//       });
//     }
//     _videoPlayerController = CachedVideoPlayerPlusController.networkUrl(
//       Uri.parse(videoUrl),
//       invalidateCacheIfOlderThan: const Duration(days: 69),
//     )..initialize().then((_) {
//         setState(() {
//           _videoPlayerController?.play();
//           _startAnimation();
//         });
//       });

//     _videoPlayerController?.addListener(() {
//       if (_videoPlayerController!.value.isInitialized &&
//           !_videoPlayerController!.value.isPlaying &&
//           _videoPlayerController!.value.position >=
//               _videoPlayerController!.value.duration) {
//         _onNextVideo();
//       }
//     });
//   }

//   void _preloadNextVideo(String videoUrl) {
//     _nextVideoPlayerController?.dispose();
//     _nextVideoPlayerController =
//         CachedVideoPlayerPlusController.networkUrl(Uri.parse(videoUrl))
//           ..initialize().then((_) {});
//   }

//   void _startAnimation() {
//     _animationController?.dispose(); // Dispose the previous controller
//     _animationController = AnimationController(
//       vsync: this,
//       duration:
//           _videoPlayerController?.value.duration ?? const Duration(seconds: 5),
//     )..forward();

//     // Add listener to update UI when animation progresses
//     _animationController?.addListener(() {
//       setState(() {}); // Forces a rebuild to update progress bar
//     });

//     _animationController?.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         _onNextVideo(); // Handle the transition to the next video when animation completes
//       }
//     });
//   }

//   void _onNextVideo() {
//     // If there are more videos in the current story, move to the next video
//     if (currentMediaIndex <
//         storiesdata![currentStoryIndex].storyList!.length - 1) {
//       setState(() {
//         currentMediaIndex++;

//         // Switch to the preloaded video controller
//         if (_nextVideoPlayerController != null &&
//             _nextVideoPlayerController!.value.isInitialized) {
//           _videoPlayerController = _nextVideoPlayerController;
//           _nextVideoPlayerController = null; // Clear the next controller
//           _videoPlayerController?.play();
//           _startAnimation();
//         } else {
//           _initializeVideoPlayer(
//               storiesdata![currentStoryIndex].storyList![currentMediaIndex]);
//         }

//         // Preload the next video if it exists
//         if (currentMediaIndex + 1 <
//             storiesdata![currentStoryIndex].storyList!.length) {
//           _preloadNextVideo(storiesdata![currentStoryIndex]
//               .storyList![currentMediaIndex + 1]);
//         }
//       });
//     } else {
//       _onNextStory();
//     }
//   }

  // void _onPreviousVideo() {
  //   // If there are more videos in the current story, move to the previous video
  //   if (currentMediaIndex > 0) {
  //     setState(() {
  //       currentMediaIndex--;
  //       _initializeVideoPlayer(
  //           storiesdata![currentStoryIndex].storyList![currentMediaIndex]);
  //     });
  //   } else {
  //     // If no more videos in the current story, move to the previous story
  //     _onPreviousStory();
  //   }
  // }

//   void _onNextStory() {
//     if (currentStoryIndex < storiesdata!.length - 1) {
//       setState(() {
//         currentStoryIndex++;
//         currentMediaIndex = 0;
//       });
//       _restartStory();
//     } else {
//       // All stories completed
//       _animationController?.dispose();
//       _videoPlayerController?.dispose();
//       _nextVideoPlayerController?.dispose();
//       Navigator.pop(context);
//     }
//   }

//   void _onPreviousStory() {
//     if (currentMediaIndex > 0) {
//       setState(() {
//         currentMediaIndex--;
//       });
//       _restartStory();
//     } else if (currentStoryIndex > 0) {
//       setState(() {
//         currentStoryIndex--;
//         currentMediaIndex =
//             storiesdata![currentStoryIndex].storyList!.length - 1;
//       });
//       _restartStory();
//     }
//   }

//   void _restartStory() {
//     _initializeVideoPlayer(
//         storiesdata![currentStoryIndex].storyList![currentMediaIndex]);

//     if (currentMediaIndex + 1 <
//         storiesdata![currentStoryIndex].storyList!.length) {
//       _preloadNextVideo(
//           storiesdata![currentStoryIndex].storyList![currentMediaIndex + 1]);
//     }
//   }

//   @override
//   void dispose() {
//     _animationController?.dispose();
//     _videoPlayerController?.dispose();
//     _nextVideoPlayerController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTapDown: (details) {
//           final screenWidth = MediaQuery.of(context).size.width;
//           final screenHeight = MediaQuery.of(context).size.height;

//           if (details.globalPosition.dx < screenWidth / 3) {
//             if (details.globalPosition.dy > screenHeight * 0.8) {
//               _onPreviousVideo();
//             } else {
//               _onPreviousStory();
//             }
//           } else {
//             _onNextVideo();
//           }
//         },
//         child: Stack(
//           children: [
//             _videoPlayerController != null &&
//                     _videoPlayerController!.value.isInitialized
//                 ? CachedVideoPlayerPlus(_videoPlayerController!)
//                 : const Center(
//                     child: CircularProgressIndicator(),
//                   ),
//             SafeArea(
//               child: Column(
//                 children: [
//                   _animationController != null
//                       ? _buildProgressBar()
//                       : const SizedBox.shrink(),
//                   _buildStoryHeader(),
//                 ],
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: _buildProfileList(),
//             ),
//             const SizedBox(height: 4),
//             Align(
//               alignment: Alignment.bottomLeft,
//               child: Container(
//                 margin: const EdgeInsets.all(4).copyWith(left: 16),
//                 child: Text(
//                   storiesdata![currentStoryIndex].description ?? "",
//                   style: WybFonts.normal14.copyWith(color: WybColor.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProgressBar() {
//     return Row(
//       children: List.generate(
//         storiesdata![currentStoryIndex].storyList!.length,
//         (index) => Expanded(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             child: LinearProgressIndicator(
//               value: index < currentMediaIndex
//                   ? 1
//                   : index == currentMediaIndex
//                       ? _animationController?.value ?? 0
//                       : 0,
//               valueColor: const AlwaysStoppedAnimation(Colors.white),
//               backgroundColor: WybColor.white.withOpacity(0.5),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStoryHeader() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               CachedNetworkImage(
//                 imageUrl: storiesdata![currentStoryIndex].profilePic!,
//                 imageBuilder: (context, imageProvider) => Container(
//                   height: 40,
//                   width: 40,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                         image: imageProvider, fit: BoxFit.cover),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 storiesdata![currentStoryIndex].name!,
//                 style: WybFonts.bold14.copyWith(color: WybColor.white),
//               ),
//               const SizedBox(width: 4),
//               Text(
//                 storiesdata![currentStoryIndex].postedTime!,
//                 style: WybFonts.bold14.copyWith(color: WybColor.white),
//               ),
//             ],
//           ),
//           InkWell(
//             onTap: () => GoRouter.of(context).pop(),
//             child: const Icon(
//               Icons.clear,
//               color: WybColor.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

  // Widget _buildProfileList() {
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 28),
  //     height: 100,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: storiesdata!.length,
  //       itemBuilder: (context, index) {
  //         bool isActive = index == currentStoryIndex;

  //         return GestureDetector(
  //           onTap: () {
  //             setState(() {
  //               currentStoryIndex = index;
  //               currentMediaIndex = 0;
  //               _restartStory();
  //             });
  //           },
  //           child: Stack(
  //             children: [
  //               Container(
  //                 margin: const EdgeInsets.symmetric(horizontal: 8),
  //                 decoration: BoxDecoration(
  //                   shape: BoxShape.circle,
  //                   border: isActive
  //                       ? const GradientBoxBorder(
  //                           width: 3,
  //                           gradient: LinearGradient(colors: [
  //                             WybColor.secondary,
  //                             WybColor.tertiary,
  //                             WybColor.quaternary,
  //                           ]),
  //                         )
  //                       : Border.all(width: 0),
  //                 ),
  //                 child: CircleAvatar(
  //                   radius: isActive ? 50 : 30,
  //                   backgroundImage: CachedNetworkImageProvider(
  //                       storiesdata![index].profilePic!),
  //                 ),
  //               ),
  //               Positioned(
  //                 left: 8,
  //                 child: isActive
  //                     ? Text(
  //                         storiesdata![index].emoji ?? "",
  //                         style: const TextStyle(fontSize: 24),
  //                       )
  //                     : const SizedBox.shrink(),
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
// }



//lastest

// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cached_video_player_plus/cached_video_player_plus.dart';
// import 'package:gradient_borders/gradient_borders.dart';
// import 'package:wyb_assignment/model/story_data_model.dart';
// import 'package:wyb_ds/wyb_ds.dart';

// import 'json_data.dart';

// class StoriesScreen extends StatefulWidget {
//   const StoriesScreen({super.key});

//   @override
//   State<StoriesScreen> createState() => _StoriesScreenState();
// }

// class _StoriesScreenState extends State<StoriesScreen>
//     with TickerProviderStateMixin {
//   List<StoryDataModel>? storiesdata;
//   int currentStoryIndex = 0;
//   int currentMediaIndex = 0;
//   AnimationController? _animationController;
//   CachedVideoPlayerPlusController? _videoPlayerController;
//   CachedVideoPlayerPlusController? _nextVideoPlayerController;

//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     storiesdata = storyFromJson(jsonData);
//     _loadStory();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _centerCurrentStory(); // Center the current story when the screen first loads
//     });
//   }

//   @override
//   void didUpdateWidget(covariant StoriesScreen oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     _centerCurrentStory(); // Ensure the active story is centered after widget updates
//   }

//   void _centerCurrentStory() {
//     if (_scrollController.hasClients && storiesdata != null) {
//       double screenWidth = MediaQuery.of(context).size.width;
//       double itemWidth = 100.0;
//       double scrollPosition =
//           (itemWidth * currentStoryIndex) - (screenWidth / 2 - itemWidth / 2);

//       _scrollController.animateTo(
//         scrollPosition.clamp(0.0, _scrollController.position.maxScrollExtent),
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   void _loadStory() {
//     _initializeVideoPlayer(
//         storiesdata![currentStoryIndex].storyList![currentMediaIndex]);

//     if (currentMediaIndex + 1 <
//         storiesdata![currentStoryIndex].storyList!.length) {
//       _preloadNextVideo(
//           storiesdata![currentStoryIndex].storyList![currentMediaIndex + 1]);
//     }
//   }

//   void _initializeVideoPlayer(String videoUrl) {
//     final lastVideoController = _videoPlayerController;
//     if (lastVideoController != null) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         lastVideoController.dispose();
//       });
//     }
//     _videoPlayerController = CachedVideoPlayerPlusController.networkUrl(
//       Uri.parse(videoUrl),
//     )..initialize().then((_) {
//         setState(() {
//           _videoPlayerController?.play();
//           _startAnimation();
//         });
//       });

//     _videoPlayerController?.addListener(() {
//       if (_videoPlayerController!.value.isInitialized &&
//           !_videoPlayerController!.value.isPlaying &&
//           _videoPlayerController!.value.position >=
//               _videoPlayerController!.value.duration) {
//         _onNextVideo();
//       }
//     });
//   }

//   void _preloadNextVideo(String videoUrl) {
//     _nextVideoPlayerController?.dispose();
//     _nextVideoPlayerController =
//         CachedVideoPlayerPlusController.networkUrl(Uri.parse(videoUrl))
//           ..initialize().then((_) {});
//   }

//   void _startAnimation() {
//     _animationController?.dispose();
//     _animationController = AnimationController(
//       vsync: this,
//       duration:
//           _videoPlayerController?.value.duration ?? const Duration(seconds: 5),
//     )..forward();

//     _animationController?.addListener(() {
//       setState(() {}); // Forces a rebuild to update progress bar
//     });

//     _animationController?.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         _onNextVideo();
//       }
//     });
//   }

//   void _onNextVideo() {
//     if (currentMediaIndex <
//         storiesdata![currentStoryIndex].storyList!.length - 1) {
//       setState(() {
//         currentMediaIndex++;
//         if (_nextVideoPlayerController != null &&
//             _nextVideoPlayerController!.value.isInitialized) {
//           _videoPlayerController = _nextVideoPlayerController;
//           _nextVideoPlayerController = null;
//           _videoPlayerController?.play();
//           _startAnimation();
//         } else {
//           _initializeVideoPlayer(
//               storiesdata![currentStoryIndex].storyList![currentMediaIndex]);
//         }

//         if (currentMediaIndex + 1 <
//             storiesdata![currentStoryIndex].storyList!.length) {
//           _preloadNextVideo(storiesdata![currentStoryIndex]
//               .storyList![currentMediaIndex + 1]);
//         }
//       });
//     } else {
//       _onNextStory();
//     }
//   }

//   void _onPreviousVideo() {
//     // If there are more videos in the current story, move to the previous video
//     if (currentMediaIndex > 0) {
//       setState(() {
//         currentMediaIndex--;
//         _initializeVideoPlayer(
//             storiesdata![currentStoryIndex].storyList![currentMediaIndex]);
//       });
//     } else {
//       // If no more videos in the current story, move to the previous story
//       _onPreviousStory();
//     }
//   }

//   void _onNextStory() {
//     if (currentStoryIndex < storiesdata!.length - 1) {
//       setState(() {
//         currentStoryIndex++;
//         currentMediaIndex = 0;
//       });
//       _restartStory();
//     } else {
//       _animationController?.dispose();
//       _videoPlayerController?.dispose();
//       _nextVideoPlayerController?.dispose();
//       Navigator.pop(context);
//     }
//   }

//   void _onPreviousStory() {
//     if (currentStoryIndex > 0) {
//       setState(() {
//         currentStoryIndex--;
//         currentMediaIndex = 0;
//       });
//       _restartStory();
//     }
//   }

//   void _restartStory() {
//     _initializeVideoPlayer(
//         storiesdata![currentStoryIndex].storyList![currentMediaIndex]);

//     if (currentMediaIndex + 1 <
//         storiesdata![currentStoryIndex].storyList!.length) {
//       _preloadNextVideo(
//           storiesdata![currentStoryIndex].storyList![currentMediaIndex + 1]);
//     }
//   }

//   @override
//   void dispose() {
//     _animationController?.dispose();
//     _videoPlayerController?.dispose();
//     _nextVideoPlayerController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onHorizontalDragEnd: (details) {
//           if (details.velocity.pixelsPerSecond.dx < 0) {
//             _onNextStory(); // Swipe Left: show next story
//           } else if (details.velocity.pixelsPerSecond.dx > 0) {
//             _onPreviousStory(); // Swipe Right: show previous story
//           }
//         },
//         onTapUp: (details) {
//           final screenWidth = MediaQuery.of(context).size.width;
//           final tapPosition = details.globalPosition.dx;

//           if (tapPosition < screenWidth / 3) {
//             _onPreviousVideo();
//             // _onPreviousStory(); // Tap on left side to go to the previous story
//           } else if (tapPosition > screenWidth * 2 / 3) {
//             _onNextVideo();
//             // _onNextStory(); // Tap on right side to go to the next story
//           } else {
//             _onNextVideo(); // Tap in the middle to move to the next video
//           }
//         },
//         child: Stack(
//           children: [
//             _videoPlayerController != null &&
//                     _videoPlayerController!.value.isInitialized
//                 ? CachedVideoPlayerPlus(_videoPlayerController!)
//                 : const Center(child: CircularProgressIndicator()),
//             SafeArea(
//               child: Column(
//                 children: [
//                   _animationController != null
//                       ? _buildProgressBar()
//                       : const SizedBox.shrink(),
//                   _buildStoryHeader(),
//                 ],
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: _buildProfileList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProgressBar() {
//     return Row(
//       children: List.generate(
//         storiesdata![currentStoryIndex].storyList!.length,
//         (index) => Expanded(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             child: LinearProgressIndicator(
//               value: index < currentMediaIndex
//                   ? 1
//                   : index == currentMediaIndex
//                       ? _animationController?.value ?? 0
//                       : 0,
//               valueColor: const AlwaysStoppedAnimation(Colors.white),
//               backgroundColor: WybColor.white.withOpacity(0.5),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStoryHeader() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               CachedNetworkImage(
//                 imageUrl: storiesdata![currentStoryIndex].profilePic!,
//                 imageBuilder: (context, imageProvider) => Container(
//                   height: 40,
//                   width: 40,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                         image: imageProvider, fit: BoxFit.cover),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 storiesdata![currentStoryIndex].name!,
//                 style: WybFonts.bold14.copyWith(color: WybColor.white),
//               ),
//               const SizedBox(width: 4),
//               Text(
//                 storiesdata![currentStoryIndex].postedTime!,
//                 style: WybFonts.bold14.copyWith(color: WybColor.white),
//               ),
//             ],
//           ),
//           InkWell(
//             onTap: () => Navigator.pop(context),
//             child: const Icon(Icons.clear, color: WybColor.white),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfileList() {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 28),
//       height: 100,
//       child: ListView.builder(
//         controller: _scrollController,
//         scrollDirection: Axis.horizontal,
//         itemCount: storiesdata!.length,
//         itemBuilder: (context, index) {
//           bool isActive = index == currentStoryIndex;

//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 currentStoryIndex = index;
//                 currentMediaIndex = 0;
//                 _restartStory();
//               });
//             },
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 8),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: isActive
//                         ? const GradientBoxBorder(
//                             width: 3,
//                             gradient: LinearGradient(colors: [
//                               WybColor.secondary,
//                               WybColor.tertiary,
//                               WybColor.quaternary,
//                             ]),
//                           )
//                         : Border.all(width: 0),
//                   ),
//                   child: CircleAvatar(
//                     radius: isActive ? 50 : 30,
//                     backgroundImage: CachedNetworkImageProvider(
//                         storiesdata![index].profilePic!),
//                   ),
//                 ),
//                 Positioned(
//                   right: 8,
//                   top: 0,
//                   child: isActive
//                       ? Text(
//                           storiesdata![index].emoji ?? "",
//                           style: const TextStyle(fontSize: 24),
//                         )
//                       : const SizedBox.shrink(),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



