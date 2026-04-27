import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class ApiClient {
  final http.Client client;

  ApiClient({http.Client? client}) : client = client ?? http.Client();

  Uri uri(String path) {
    return Uri.parse('${ApiConfig.baseUrl}$path');
  }
}