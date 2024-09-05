List<StoryDataModel> storyFromJson(List<Map<String, Object>> str) =>
    List<StoryDataModel>.from(str.map((x) => StoryDataModel.fromJson(x)));

class StoryDataModel {
  String? name;
  String? profilePic;
  String? emoji;
  String? description;
  List<String>? storyList;

  StoryDataModel(
      {this.name,
      this.profilePic,
      this.emoji,
      this.description,
      this.storyList});

  StoryDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profilePic = json['profile_pic'];
    emoji = json['emoji'];
    description = json['description'];
    storyList = json['story_list'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['profile_pic'] = profilePic;
    data['emoji'] = emoji;
    data['description'] = description;
    data['story_list'] = storyList;
    return data;
  }
}
