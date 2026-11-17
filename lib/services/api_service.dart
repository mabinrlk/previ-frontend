import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Endereço do backend local no emulador Android.
  static const String baseUrl = 'http://10.0.2.2:8080';

  static String? token;

  static void definirToken(String novoToken) {
    token = novoToken;
  }

  static void limparToken() {
    token = null;
  }

  static Map<String, String> get headers {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null)
        'Authorization': 'Bearer $token',
    };
  }

  static Future<dynamic> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    );

    return processarResposta(response);
  }

  static Future<dynamic> post(
      String endpoint, [
        Map<String, dynamic>? dados,
      ]) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: dados == null ? null : jsonEncode(dados),
    );

    return processarResposta(response);
  }

  static Future<dynamic> patch(
      String endpoint,
      Map<String, dynamic> dados,
      ) async {
    final response = await http.patch(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(dados),
    );

    return processarResposta(response);
  }

  static Future<dynamic> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    );

    return processarResposta(response);
  }

  static dynamic processarResposta(http.Response response) {
    if (response.statusCode >= 200 &&
        response.statusCode < 300) {
      if (response.body.isEmpty) return null;

      return jsonDecode(response.body);
    }

    throw Exception(
      'Erro ${response.statusCode}: ${response.body}',
    );
  }
}
