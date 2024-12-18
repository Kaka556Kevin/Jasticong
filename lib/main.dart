import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


void main() {
  runApp(const JasticongApp());
}

class JasticongApp extends StatelessWidget {
  const JasticongApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primarySwatch: Colors.blue,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
  ),
  home: const RegistrationPage(),
);
  }
}

// Halaman Registrasi
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;

  Future<void> _registerUser() async {
    String name = _nameController.text.trim();
    if (name.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('http://localhost:3000/api/users/register'),
      body: jsonEncode({'name': name}),
      headers: {'Content-Type': 'application/json'},
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 201) {
      // Berhasil registrasi
      final responseData = jsonDecode(response.body);
      String userId = responseData['userId'];

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardPage(userName: name, userId: userId),
        ),
      );
    } else {
      // Gagal registrasi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to register user. Please try again!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Enter your name'),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _registerUser,
                      child: const Text('Register'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

// Halaman Dashboard dengan Tab
class DashboardPage extends StatefulWidget {
  final String userName;
  final String userId;

  const DashboardPage({super.key, required this.userName, required this.userId});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello, ${widget.userName}!'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Pesan'),
            Tab(text: 'Pesanan'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MessagePage(userId: widget.userId),
          OrderPage(userId: widget.userId),
        ],
      ),
    );
  }
}

// Halaman Pesan (CRUD)
class MessagePage extends StatefulWidget {
  final String userId;

  const MessagePage({super.key, required this.userId});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List messages = [];
  final TextEditingController _messageController = TextEditingController();

  Future<void> fetchMessages() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/api/messages/${widget.userId}'),
    );
    if (response.statusCode == 200) {
      setState(() {
        messages = jsonDecode(response.body);
      });
    }
  }

  Future<void> addMessage(String message) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/messages'),
      body: jsonEncode({'userId': widget.userId, 'message': message}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      fetchMessages();
      _messageController.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final msg = messages[index];
          return ListTile(
            title: Text(msg['message']),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add Message'),
              content: TextField(
                controller: _messageController,
                decoration: const InputDecoration(hintText: 'Enter your message'),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    addMessage(_messageController.text);
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Halaman Pesanan
class OrderPage extends StatelessWidget {
  final String userId;

  const OrderPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Pesanan Page for User: $userId'),
    );
  }
}
