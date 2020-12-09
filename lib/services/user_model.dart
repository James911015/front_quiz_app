class UserModel {
  String name;
  int age;
  String email;
  String password;

  UserModel({
    this.name,
    this.age,
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{
      'name': name.trim(),
      'age':   age.toString(),
      'email': email.trim(),
      'password': password.trim(),
    };
    return map;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      age: json['age'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }
}
