import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PesanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesan'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchMessages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final messages = snapshot.data ?? [];
          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              return ListTile(
                title: Text(message['food_name']),
                subtitle: Text(message['details']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => editMessage(context, message),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deleteMessage(context, message['id']),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => createMessage(context),
      ),
    );
  }

  Future<List<dynamic>> fetchMessages() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/messages/1'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load messages');
      }
    } catch (e) {
      throw Exception('Error fetching messages: $e');
    }
  }

  void createMessage(BuildContext context) {
    // Navigate to a form page for creating a new message
    print('Navigate to create message page');
  }

  void editMessage(BuildContext context, Map<String, dynamic> message) {
    // Navigate to a form page for editing the message
    print('Navigate to edit message page for message: $message');
  }

  Future<void> deleteMessage(BuildContext context, int id) async {
    try {
      final response = await http.delete(Uri.parse('http://localhost:3000/api/messages/$id'));
      if (response.statusCode == 200) {
        print('Message deleted successfully');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Message deleted')));
      } else {
        throw Exception('Failed to delete message');
      }
    } catch (e) {
      print('Error deleting message: $e');
    }
  }
}
