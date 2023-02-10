import 'package:flutter_story/src/core/domain/entities/story_entity.dart';

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
  StoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    this.lat,
    this.lon,
  });

  String id;
  String name;
  String description;
  String photoUrl;
  DateTime createdAt;
  double? lat;
  double? lon;

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        photoUrl: json["photoUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
      );

  StoryEnity toEntity() =>
      StoryEnity(id, name, description, photoUrl, createdAt, lat, lon);
}
