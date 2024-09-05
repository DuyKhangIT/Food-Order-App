class RegisterRequest {
  String userName;
  String password;

  RegisterRequest(this.userName, this.password);

  Map<String, dynamic> toBodyRequest() => {
    'username': userName,
    'password': password,
  };
}
