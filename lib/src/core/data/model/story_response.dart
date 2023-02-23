import 'story_model.dart';

class StoryResponse {
  final bool error;
  final String message;
  final StoryModel story;

  StoryResponse(this.error, this.message, this.story);

  factory StoryResponse.fromJson(Map json) => StoryResponse(
        json["error"],
        json["message"],
        StoryModel.fromJson(json["story"]),
      );
}
