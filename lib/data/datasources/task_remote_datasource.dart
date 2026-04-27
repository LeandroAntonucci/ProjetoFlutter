import 'dart:convert';

import '../../../core/network/api_client.dart';
import '../models/task_model.dart';

class TasksRemoteDataSource {
  final ApiClient apiClient;

  TasksRemoteDataSource({
    required this.apiClient,
  });

  Future<List<TaskModel>> getTasks() async {
    final res = await apiClient.client.get(apiClient.uri('/tasks'));

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Erro ao buscar tasks');
    }

    final data = jsonDecode(res.body) as List<dynamic>;

    return data
        .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}