import 'dart:convert';
import 'package:http/http.dart' as http;

import 'auth_response.dart';

abstract class AuthData {
  Future<AuthResponseDto> login({
    required String username,
    required String password,
  });

  Future<void> register({
    required String username,
    required String password,
  });
}

class AuthProvider implements AuthData {
  AuthProvider({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;

  static const String _baseUrl =
      'https://mobile-ios-login.zani0x03.eti.br/api';

  static const String _sistemaId =
      '597463d4-3762-431d-a3d2-05122e45d2c6';

  Uri get _loginUri =>
      Uri.parse('$_baseUrl/auth/login');

  Uri get _registerUri =>
      Uri.parse('$_baseUrl/register');

  @override
  Future<AuthResponseDto> login({
    required String username,
    required String password,
  }) async {
    final body = {
      'username': username,
      'password': password,
      'sistemaId': _sistemaId.trim(),
    };

    print('========== LOGIN ==========');
    print('URL: $_loginUri');
    print('BODY: ${jsonEncode(body)}');

    final response = await _client.post(
      _loginUri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    print('STATUS LOGIN: ${response.statusCode}');
    print('RESPONSE LOGIN: ${response.body}');
    print('===========================');

    if (response.statusCode == 200) {
      return AuthResponseDto.fromJson(
        jsonDecode(response.body),
      );
    }

    throw Exception(
      _extractErrorMessage(response.body) ??
          'Credenciais inválidas ou erro no servidor.',
    );
  }

  @override
  Future<void> register({
    required String username,
    required String password,
  }) async {
    final fakeEmail =
        '${username.toLowerCase()}@lavie.com';

    final body = {
      'name': username,
      'surname': 'User',
      'login': username,
      'email': fakeEmail,
      'password': password,
      'sistemaId': _sistemaId.trim(),
    };

    print('======== REGISTER =========');
    print('URL: $_registerUri');
    print('BODY: ${jsonEncode(body)}');

    final response = await _client.post(
      _registerUri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    print('STATUS REGISTER: ${response.statusCode}');
    print('RESPONSE REGISTER: ${response.body}');
    print('===========================');

    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      return;
    }

    throw Exception(
      _extractErrorMessage(response.body) ??
          'Erro ao registrar usuário.',
    );
  }

  String? _extractErrorMessage(String body) {
    try {
      final decoded = jsonDecode(body);

      if (decoded is Map<String, dynamic>) {
        return decoded['message']?.toString() ??
            decoded['error']?.toString() ??
            decoded['detail']?.toString();
      }
    } catch (_) {}

    return null;
  }
}
