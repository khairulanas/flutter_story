// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stories_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StoriesResponse _$StoriesResponseFromJson(Map<String, dynamic> json) {
  return _StoriesResponse.fromJson(json);
}

/// @nodoc
mixin _$StoriesResponse {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<StoryModel> get listStory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoriesResponseCopyWith<StoriesResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoriesResponseCopyWith<$Res> {
  factory $StoriesResponseCopyWith(
          StoriesResponse value, $Res Function(StoriesResponse) then) =
      _$StoriesResponseCopyWithImpl<$Res, StoriesResponse>;
  @useResult
  $Res call({bool error, String message, List<StoryModel> listStory});
}

/// @nodoc
class _$StoriesResponseCopyWithImpl<$Res, $Val extends StoriesResponse>
    implements $StoriesResponseCopyWith<$Res> {
  _$StoriesResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? listStory = null,
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
      listStory: null == listStory
          ? _value.listStory
          : listStory // ignore: cast_nullable_to_non_nullable
              as List<StoryModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StoriesResponseCopyWith<$Res>
    implements $StoriesResponseCopyWith<$Res> {
  factory _$$_StoriesResponseCopyWith(
          _$_StoriesResponse value, $Res Function(_$_StoriesResponse) then) =
      __$$_StoriesResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool error, String message, List<StoryModel> listStory});
}

/// @nodoc
class __$$_StoriesResponseCopyWithImpl<$Res>
    extends _$StoriesResponseCopyWithImpl<$Res, _$_StoriesResponse>
    implements _$$_StoriesResponseCopyWith<$Res> {
  __$$_StoriesResponseCopyWithImpl(
      _$_StoriesResponse _value, $Res Function(_$_StoriesResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? listStory = null,
  }) {
    return _then(_$_StoriesResponse(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      null == listStory
          ? _value._listStory
          : listStory // ignore: cast_nullable_to_non_nullable
              as List<StoryModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StoriesResponse implements _StoriesResponse {
  const _$_StoriesResponse(
      this.error, this.message, final List<StoryModel> listStory)
      : _listStory = listStory;

  factory _$_StoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$$_StoriesResponseFromJson(json);

  @override
  final bool error;
  @override
  final String message;
  final List<StoryModel> _listStory;
  @override
  List<StoryModel> get listStory {
    if (_listStory is EqualUnmodifiableListView) return _listStory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listStory);
  }

  @override
  String toString() {
    return 'StoriesResponse(error: $error, message: $message, listStory: $listStory)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StoriesResponse &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._listStory, _listStory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message,
      const DeepCollectionEquality().hash(_listStory));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StoriesResponseCopyWith<_$_StoriesResponse> get copyWith =>
      __$$_StoriesResponseCopyWithImpl<_$_StoriesResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StoriesResponseToJson(
      this,
    );
  }
}

abstract class _StoriesResponse implements StoriesResponse {
  const factory _StoriesResponse(final bool error, final String message,
      final List<StoryModel> listStory) = _$_StoriesResponse;

  factory _StoriesResponse.fromJson(Map<String, dynamic> json) =
      _$_StoriesResponse.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  List<StoryModel> get listStory;
  @override
  @JsonKey(ignore: true)
  _$$_StoriesResponseCopyWith<_$_StoriesResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
