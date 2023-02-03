class LoginResponse {
  final bool error;
  final String message;
  final LoginResult loginResult;

  LoginResponse(this.error, this.message, this.loginResult);

  factory LoginResponse.fromJson(Map json) => LoginResponse(json["error"],
      json["message"], LoginResult.fromJson(json["loginResult"]));
}

class LoginResult {
  final String userId;
  final String name;
  final String token;

  LoginResult(this.userId, this.name, this.token);

  factory LoginResult.fromJson(Map json) =>
      LoginResult(json["userId"], json["name"], json["token"]);
}
