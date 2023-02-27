import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_result.g.dart';

part 'login_result.freezed.dart';

@Freezed()
class LoginResult with _$LoginResult {
  const factory LoginResult(String userId, String name, String token) =
      _LoginResult;

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);
}
