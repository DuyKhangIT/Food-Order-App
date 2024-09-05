class UserResponseRegister {
  String username = "";
  String password = "";
  String id = "";


  UserResponseRegister(this.username,this.password,this.id);
  UserResponseRegister.buildDefault();
  factory UserResponseRegister.fromJson(Map<String, dynamic> json) {
    return UserResponseRegister(
      json['username'],
      json['password'],
      json['_id'],
    );
  }
}
