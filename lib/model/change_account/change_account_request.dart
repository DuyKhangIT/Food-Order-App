class ChangeAccountRequest {
  String userName;
  String oldPassword;
  String newPassword;

  ChangeAccountRequest(this.userName, this.oldPassword,this.newPassword);

  Map<String, dynamic> toBodyRequest() => {
    'username': userName,
    'oldPassword': oldPassword,
    'newPassword': newPassword,
  };
}
