import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_response.g.dart';
part 'common_response.freezed.dart';

@Freezed()
class CommonResponse with _$CommonResponse {
  const factory CommonResponse(bool error, String message) = _CommonResponse;

  factory CommonResponse.fromJson(Map<String, dynamic> json) =>
      _$CommonResponseFromJson(json);
}
