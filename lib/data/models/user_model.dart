class UserModel {
  final int id;
  final String email;
  final String? name;
  final String role;

  UserModel({
    required this.id,
    required this.email,
    this.name,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      email: json['email'] as String,
      name: json['name'] as String?,
      role: json['role'] as String,
    );
  }
}