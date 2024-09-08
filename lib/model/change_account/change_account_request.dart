class ChangeAccountRequest {
  String email;
  String oldPassword;
  String newPassword;

  ChangeAccountRequest(this.email, this.oldPassword,this.newPassword);

  Map<String, dynamic> toBodyRequest() => {
    'email': email,
    'oldPassword': oldPassword,
    'newPassword': newPassword,
  };
}
