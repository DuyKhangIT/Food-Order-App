class UserChangeAccountResponse {
  String id = "";
  String username = "";

  UserChangeAccountResponse(this.id, this.username);
  UserChangeAccountResponse.buildDefault();
  factory UserChangeAccountResponse.fromJson(Map<String, dynamic> json) {
    return UserChangeAccountResponse(
      json['_id'],
      json['username'],
    );
  }
}
