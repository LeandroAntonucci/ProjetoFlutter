class TaskAuthorModel {
  final int id;
  final String email;
  final String? name;

  const TaskAuthorModel({
    required this.id,
    required this.email,
    required this.name,
  });

  factory TaskAuthorModel.fromJson(Map<String, dynamic> json) {
    return TaskAuthorModel(
      id: json['id'] as int,
      email: json['email'] as String,
      name: json['name'] as String?,
    );
  }
}

class TaskModel {
  final int id;
  final String title;
  final String category;
  final String status;
  final String frequencyType;
  final int? intervalValue;
  final String? intervalUnit;
  final DateTime? completionDate;
  final int authorId;
  final TaskAuthorModel? author;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TaskModel({
    required this.id,
    required this.title,
    required this.category,
    required this.status,
    required this.frequencyType,
    this.intervalValue,
    this.intervalUnit,
    this.completionDate,
    required this.authorId,
    this.author,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as int,
      title: json['title'] as String,
      category: json['category'] as String,
      status: json['status'] as String,
      frequencyType: json['frequencyType'] as String,
      intervalValue: json['intervalValue'] as int?,
      intervalUnit: json['intervalUnit'] as String?,
      completionDate: json['completionDate'] != null
          ? DateTime.parse(json['completionDate'] as String)
          : null,
      authorId: json['authorId'] as int,
      author: json['author'] != null
          ? TaskAuthorModel.fromJson(json['author'] as Map<String, dynamic>)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
