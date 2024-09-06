class UserResponseRegister {
  String email = "";
  String password = "";
  String id = "";


  UserResponseRegister(this.email,this.password,this.id);
  UserResponseRegister.buildDefault();
  factory UserResponseRegister.fromJson(Map<String, dynamic> json) {
    return UserResponseRegister(
      json['email'],
      json['password'],
      json['id'],
    );
  }
}
