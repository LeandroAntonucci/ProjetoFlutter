import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UsersRemoteDatasource {
  final String baseUrl;
  final http.Client client;

  UsersRemoteDatasource({
    required this.baseUrl,
    required this.client,
  });

  Future<Map<String, dynamic>> upsertMe({
    required String firebaseToken,
  }) async {
    final res = await client.post(
      Uri.parse('$baseUrl/auth/firebase'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $firebaseToken',
      },
    );

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Falha ao sincronizar usuário');
    }

    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  Future<List<UserModel>> getUsers() async {
    final res = await client.get(Uri.parse('$baseUrl/users'));

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Falha ao buscar usuários');
    }

    final data = jsonDecode(res.body) as List<dynamic>;
    return data
        .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}