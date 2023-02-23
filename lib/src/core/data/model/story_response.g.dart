// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryResponse _$StoryResponseFromJson(Map<String, dynamic> json) =>
    StoryResponse(
      json['error'] as bool,
      json['message'] as String,
      StoryModel.fromJson(json['story'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StoryResponseToJson(StoryResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'story': instance.story,
    };
