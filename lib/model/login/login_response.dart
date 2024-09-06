import 'package:food_app_project/model/login/user_response.dart';

class LoginResponse {
  String? token = "";
  UserResponse? userResponse;

  LoginResponse(
    this.token,
    this.userResponse,
  );
  LoginResponse.buildDefault();
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      json['token'] ?? "",
      (json['user'] != null) ? UserResponse.fromJson(json['user']) : null,
    );
  }
}
