// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StoryResponse _$StoryResponseFromJson(Map<String, dynamic> json) {
  return _StoryResponse.fromJson(json);
}

/// @nodoc
mixin _$StoryResponse {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  StoryModel get story => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoryResponseCopyWith<StoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryResponseCopyWith<$Res> {
  factory $StoryResponseCopyWith(
          StoryResponse value, $Res Function(StoryResponse) then) =
      _$StoryResponseCopyWithImpl<$Res, StoryResponse>;
  @useResult
  $Res call({bool error, String message, StoryModel story});

  $StoryModelCopyWith<$Res> get story;
}

/// @nodoc
class _$StoryResponseCopyWithImpl<$Res, $Val extends StoryResponse>
    implements $StoryResponseCopyWith<$Res> {
  _$StoryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? story = null,
  }) {
    return _then(_value.copyWith(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      story: null == story
          ? _value.story
          : story // ignore: cast_nullable_to_non_nullable
              as StoryModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StoryModelCopyWith<$Res> get story {
    return $StoryModelCopyWith<$Res>(_value.story, (value) {
      return _then(_value.copyWith(story: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_StoryResponseCopyWith<$Res>
    implements $StoryResponseCopyWith<$Res> {
  factory _$$_StoryResponseCopyWith(
          _$_StoryResponse value, $Res Function(_$_StoryResponse) then) =
      __$$_StoryResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool error, String message, StoryModel story});

  @override
  $StoryModelCopyWith<$Res> get story;
}

/// @nodoc
class __$$_StoryResponseCopyWithImpl<$Res>
    extends _$StoryResponseCopyWithImpl<$Res, _$_StoryResponse>
    implements _$$_StoryResponseCopyWith<$Res> {
  __$$_StoryResponseCopyWithImpl(
      _$_StoryResponse _value, $Res Function(_$_StoryResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? story = null,
  }) {
    return _then(_$_StoryResponse(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      null == story
          ? _value.story
          : story // ignore: cast_nullable_to_non_nullable
              as StoryModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StoryResponse implements _StoryResponse {
  const _$_StoryResponse(this.error, this.message, this.story);

  factory _$_StoryResponse.fromJson(Map<String, dynamic> json) =>
      _$$_StoryResponseFromJson(json);

  @override
  final bool error;
  @override
  final String message;
  @override
  final StoryModel story;

  @override
  String toString() {
    return 'StoryResponse(error: $error, message: $message, story: $story)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StoryResponse &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.story, story) || other.story == story));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message, story);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StoryResponseCopyWith<_$_StoryResponse> get copyWith =>
      __$$_StoryResponseCopyWithImpl<_$_StoryResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StoryResponseToJson(
      this,
    );
  }
}

abstract class _StoryResponse implements StoryResponse {
  const factory _StoryResponse(
          final bool error, final String message, final StoryModel story) =
      _$_StoryResponse;

  factory _StoryResponse.fromJson(Map<String, dynamic> json) =
      _$_StoryResponse.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  StoryModel get story;
  @override
  @JsonKey(ignore: true)
  _$$_StoryResponseCopyWith<_$_StoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
