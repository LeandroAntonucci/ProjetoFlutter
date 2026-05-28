import 'dart:convert';
import 'package:http/http.dart' as http;

class AiService {
  static const String _baseUrl =
      'https://mobile-ios-ia.zani0x03.eti.br/api/ai/chat';

  final http.Client _client;

  AiService({http.Client? client})
      : _client = client ?? http.Client();

  Future<String> sendMessage({
    required String message,
    required String token,
  }) async {
    final response = await _client.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'prompt': message,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data['response']?.toString() ??
          'Sem resposta da IA';
    }

    throw Exception(
      'Erro ao conversar com IA (${response.statusCode})',
    );
  }
}
