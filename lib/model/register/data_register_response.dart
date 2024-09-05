import 'package:food_app_project/model/register/user_response.dart';

class DataResponseRegister {
  UserResponseRegister? userResponseRegister;

  DataResponseRegister(
    this.userResponseRegister,
  );
  DataResponseRegister.buildDefault();
  factory DataResponseRegister.fromJson(Map<String, dynamic> json) {
    return DataResponseRegister(
      (json['user'] != null)
          ? UserResponseRegister.fromJson(json['user'])
          : null,
    );
  }
}
