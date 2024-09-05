import 'data_response.dart';

class LoginResponse {
  bool status = false;
  DataResponseLogin? dataResponseLogin;

  LoginResponse(
    this.status,
    this.dataResponseLogin,
  );
  LoginResponse.buildDefault();
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      json['status'],
      (json['data'] != null) ? DataResponseLogin.fromJson(json['data']) : null,
    );
  }
}
