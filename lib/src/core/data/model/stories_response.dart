import 'package:flutter_story/src/core/domain/entities/story_entity.dart';

class StoriesResponse {
  final bool error;
  final String message;
  final List<StoryModel> listStory;

  StoriesResponse(this.error, this.message, this.listStory);

  factory StoriesResponse.fromJson(Map json) => StoriesResponse(
        json["error"],
        json["message"],
        (json["loginResult"] as List)
            .map((e) => StoryModel.fromJson(e))
            .toList(),
      );
}

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

class StoryModel {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final DateTime createdAt;
  final double? lat;
  final double? lon;

  StoryModel(this.id, this.name, this.description, this.photoUrl,
      this.createdAt, this.lat, this.lon);

  factory StoryModel.fromJson(Map json) => StoryModel(
      json["id"],
      json["name"],
      json["description"],
      json["photoUrl"],
      DateTime.parse(json["createdAt"]),
      double.tryParse(json["lat"]),
      double.tryParse(json["lon"]));

  StoryEnity toEntity() =>
      StoryEnity(id, name, description, photoUrl, createdAt, lat, lon);
}
