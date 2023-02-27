// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StoriesResponse _$$_StoriesResponseFromJson(Map<String, dynamic> json) =>
    _$_StoriesResponse(
      json['error'] as bool,
      json['message'] as String,
      (json['listStory'] as List<dynamic>)
          .map((e) => StoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_StoriesResponseToJson(_$_StoriesResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'listStory': instance.listStory,
    };
