import 'package:freezed_annotation/freezed_annotation.dart';

import 'story_model.dart';

part 'story_response.g.dart';

part 'story_response.freezed.dart';

@Freezed()
class StoryResponse with _$StoryResponse {
  const factory StoryResponse(bool error, String message, StoryModel story) =
      _StoryResponse;

  factory StoryResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryResponseFromJson(json);
}
