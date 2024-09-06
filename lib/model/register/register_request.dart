class RegisterRequest {
  String fullName;
  String email;
  String password;

  RegisterRequest(this.fullName, this.email, this.password);

  Map<String, dynamic> toBodyRequest() => {
        'name': fullName,
        'email': email,
        'password': password,
      };
}
