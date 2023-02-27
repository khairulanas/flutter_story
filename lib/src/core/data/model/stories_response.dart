import 'package:freezed_annotation/freezed_annotation.dart';

import 'story_model.dart';

part 'stories_response.g.dart';

part 'stories_response.freezed.dart';

@Freezed()
class StoriesResponse with _$StoriesResponse {
  const factory StoriesResponse(
          bool error, String message, List<StoryModel> listStory) =
      _StoriesResponse;

  factory StoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$StoriesResponseFromJson(json);
}
