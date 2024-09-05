import 'package:food_app_project/model/login/user_response.dart';

class DataResponseLogin {
  String token = "";
  UserResponse? userResponse;

  DataResponseLogin(
    this.token,
    this.userResponse,
  );
  DataResponseLogin.buildDefault();
  factory DataResponseLogin.fromJson(Map<String, dynamic> json) {
    return DataResponseLogin(
      json['token'],
      (json['user'] != null) ? UserResponse.fromJson(json['user']) : null,
    );
  }
}
