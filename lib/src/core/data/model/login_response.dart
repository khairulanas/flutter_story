import 'package:freezed_annotation/freezed_annotation.dart';

import 'login_result.dart';

part 'login_response.g.dart';

part 'login_response.freezed.dart';

@Freezed()
class LoginResponse with _$LoginResponse {
  const factory LoginResponse(
      bool error, String message, LoginResult loginResult) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
