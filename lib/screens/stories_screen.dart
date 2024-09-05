import 'package:flutter/material.dart';
import 'package:wyb_assignment/model/story_data_model.dart';
import 'package:wyb_assignment/screens/json_data.dart';
import 'package:wyb_assignment/screens/video_player.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({super.key});

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  List<StoryDataModel>? storiesdata;

  @override
  void initState() {
    storiesdata = storyFromJson(jsonData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomVideoPlayer(
            videoUrl: storiesdata![0].storyList![0],
          ),
        ],
      ),
    );
  }
}
