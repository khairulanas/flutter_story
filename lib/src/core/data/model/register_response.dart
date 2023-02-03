class CommonResponse {
  final bool error;
  final String message;

  CommonResponse(this.error, this.message);

  factory CommonResponse.fromJson(Map json) =>
      CommonResponse(json["error"], json["message"]);
}
