import 'package:flutter_story/src/core/domain/entities/story_entity.dart';

import 'story_model.dart';

class StoriesResponse {
  final bool error;
  final String message;
  final List<StoryModel> listStory;

  StoriesResponse(this.error, this.message, this.listStory);

  factory StoriesResponse.fromJson(Map json) => StoriesResponse(
        json["error"],
        json["message"],
        List<StoryModel>.from(
            json["listStory"].map((x) => StoryModel.fromJson(x))),
      );
}
