import 'dart:convert';
import 'package:http/http.dart' as http;

class MessageService {
  final String baseUrl;

  MessageService({required this.baseUrl});

  Future<List<Map<String, dynamic>>> fetchMessages(String userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/messages/$userId'));
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(jsonDecode(response.body));
      } else {
        throw Exception('Failed to fetch messages');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> addMessage(String userId, String message) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/messages'),
        body: jsonEncode({'userId': userId, 'message': message}),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to add message');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
