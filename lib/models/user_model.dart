class UserModel {
  final String username;
  final String password;

  UserModel({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'userName': username,
      'pass': password,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['userName'] ?? '',
      password: json['pass'] ?? '',
    );
  }
}