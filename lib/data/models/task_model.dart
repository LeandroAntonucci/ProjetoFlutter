class TaskModel {
  final int id;
  final String title;
  final String category;
  final String status;
  final String frequencyType;
  final String? completionDate;
  final int authorId;

  TaskModel({
    required this.id,
    required this.title,
    required this.category,
    required this.status,
    required this.frequencyType,
    this.completionDate,
    required this.authorId,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as int,
      title: json['title'] as String,
      category: json['category'] as String,
      status: json['status'] as String,
      frequencyType: json['frequencyType'] as String,
      completionDate: json['completionDate'] as String?,
      authorId: json['authorId'] as int,
    );
  }
}