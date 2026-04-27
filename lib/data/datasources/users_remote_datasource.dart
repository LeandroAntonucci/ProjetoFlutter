import 'dart:convert';


import '../../../core/network/api_client.dart';
import '../models/user_model.dart';

class UsersRemoteDatasource {
  final ApiClient apiClient;

  UsersRemoteDatasource({
    required this.apiClient,
  });

  Future<List<UserModel>> getUsers() async {
    final res = await apiClient.client.get(apiClient.uri('/users'));

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Erro ao buscar usuários');
    }

    final data = jsonDecode(res.body) as List<dynamic>;

    return data
        .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}