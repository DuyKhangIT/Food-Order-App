class UserResponse {
  String id = "";
  String username = "";

  UserResponse(this.id, this.username);
  UserResponse.buildDefault();
  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      json['_id'],
      json['username'],
    );
  }
}
