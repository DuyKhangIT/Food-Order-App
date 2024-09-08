class ChangeAccountResponse {
  bool status = false;
  String message = "";

  ChangeAccountResponse(
    this.status,
    this.message,
  );
  ChangeAccountResponse.buildDefault();
  factory ChangeAccountResponse.fromJson(Map<String, dynamic> json) {
    return ChangeAccountResponse(
      json['status'],
      json['message'],
    );
  }
}
