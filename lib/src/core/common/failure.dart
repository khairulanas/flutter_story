class Failure {
  final String message;
  final FailurType failurType;

  Failure(this.message, {this.failurType = FailurType.none});
}

enum FailurType { none, noInternet }
