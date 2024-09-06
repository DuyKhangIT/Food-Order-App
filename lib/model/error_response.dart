class ErrorResponse {
  int statusCode = 0;
  String errorMessage;

  ErrorResponse(
    this.statusCode,
    this.errorMessage,
  );
  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      json['statusCode'],
      json['message'],
    );
  }
}
