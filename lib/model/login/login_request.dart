class LoginRequest {
  String userName;
  String password;

  LoginRequest(this.userName, this.password);

  Map<String, dynamic> toBodyRequest() => {
    'username': userName,
    'password': password,
  };
}
