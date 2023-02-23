// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoriesResponse _$StoriesResponseFromJson(Map<String, dynamic> json) =>
    StoriesResponse(
      json['error'] as bool,
      json['message'] as String,
      (json['listStory'] as List<dynamic>)
          .map((e) => StoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StoriesResponseToJson(StoriesResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'listStory': instance.listStory,
    };
