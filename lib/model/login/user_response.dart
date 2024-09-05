class UserResponse {
  String id = "";
  String email = "";

  UserResponse(this.id, this.email);
  UserResponse.buildDefault();
  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      json['id'],
      json['email'],
    );
  }
}
