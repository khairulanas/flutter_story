import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_model.g.dart';

part 'story_model.freezed.dart';

@Freezed()
class StoryModel with _$StoryModel {
  const factory StoryModel({
    required String id,
    required String name,
    required String description,
    required String photoUrl,
    required DateTime createdAt,
    double? lat,
    double? lon,
  }) = _StoryModel;

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);
}
