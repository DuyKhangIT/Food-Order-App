import 'data_register_response.dart';

class RegisterResponse {
  bool status = false;
  DataResponseRegister? dataResponseRegister;

  RegisterResponse(
    this.status,
    this.dataResponseRegister,
  );
  RegisterResponse.buildDefault();
  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      json['status'],
      (json['data'] != null)
          ? DataResponseRegister.fromJson(json['data'])
          : null,
    );
  }
}
