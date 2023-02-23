import 'story_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'story_response.g.dart';

@JsonSerializable()
class StoryResponse {
  final bool error;
  final String message;
  final StoryModel story;

  StoryResponse(this.error, this.message, this.story);

  factory StoryResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoryResponseToJson(this);
}
