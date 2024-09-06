import 'package:food_app_project/model/register/user_response.dart';

class RegisterResponse {
  UserResponseRegister? userResponseRegister;

  RegisterResponse(
    this.userResponseRegister,
  );
  RegisterResponse.buildDefault();
  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      (json['user'] != null)
          ? UserResponseRegister.fromJson(json['user'])
          : null,
    );
  }
}
