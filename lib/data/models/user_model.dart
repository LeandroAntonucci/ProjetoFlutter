class UserModel {
  final int id;
  final String username;
  final String? email;
  final String? name;
  final String role;
  final int? age;
  final int? height;
  final int? weight;
  final int? caregiverId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.id,
    required this.username,
    this.email,
    this.name,
    required this.role,
    this.age,
    this.height,
    this.weight,
    this.caregiverId,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String?,
      name: json['name'] as String?,
      role: json['role'] as String,
      age: json['age'] as int?,
      height: json['height'] as int?,
      weight: json['weight'] as int?,
      caregiverId: json['caregiverId'] as int?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }
}