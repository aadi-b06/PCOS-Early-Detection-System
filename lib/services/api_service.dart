import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // For Android Emulator use 10.0.2.2
  static const String baseUrl = "http://10.190.216.215:5000/predict";

  static Future<Map<String, dynamic>> predict(
      Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Server Error");
    }
  }
}