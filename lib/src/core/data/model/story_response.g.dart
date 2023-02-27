// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StoryResponse _$$_StoryResponseFromJson(Map<String, dynamic> json) =>
    _$_StoryResponse(
      json['error'] as bool,
      json['message'] as String,
      StoryModel.fromJson(json['story'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_StoryResponseToJson(_$_StoryResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'story': instance.story,
    };
