class LoginRequest {
  String email;
  String password;

  LoginRequest(this.email, this.password);

  Map<String, dynamic> toBodyRequest() => {
    'email': email,
    'password': password,
  };
}
