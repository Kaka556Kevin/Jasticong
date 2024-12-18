// import 'package:http/http.dart' as http;

// class UserAPI {
//   // Fungsi untuk mendaftarkan pengguna baru
//   static Future<void> registerUser(String name) async {
//     try {
//       final response = await http.post(
//         Uri.parse(
//             'http://localhost:3000/api/users/register'), // Rute API backend
//         body: {'name': name}, // Data yang dikirim
//       );

//       [
//         {"name": "Alice", "order_details": "Burger"},
//         {"name": "Bob", "order_details": "Pizza"},
//         {"name": "Charlie", "order_details": "Sushi"},
//         {"name": "David", "order_details": "Fried Chicken"},
//         {"name": "Eve", "order_details": "Ice Cream"}
//       ];

//       if (response.statusCode == 201) {
//         print('User registered: ${response.body}');
//       } else {
//         print('Failed to register user: ${response.body}');
//       }
//     } catch (e) {
//       print('Error registering user: $e');
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserApi {
  static const String baseUrl = 'http://localhost:3000/api/users';

  // Fungsi untuk registrasi user
  static Future<User?> registerUser(String name) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        body: {'name': name},
      );

      if (response.statusCode == 201) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to register user');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
