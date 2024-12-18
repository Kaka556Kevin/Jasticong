import 'package:flutter/material.dart';
import 'qr_code_page.dart';

class DashboardPage extends StatelessWidget {
  final String userName;
  final String userId;

  const DashboardPage({super.key, required this.userName, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              child: Text(userName.substring(0, 2).toUpperCase()),
            ),
            const SizedBox(width: 8),
            Text(userName),
          ],
        ),
        actions: [
  IconButton(
    icon: const Icon(Icons.qr_code),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QRCodePage(userId: userId),
        ),
      );
    },
  ),
],
      ),
      body: const Center(
        child: Text('Welcome to the Dashboard'),
      ),
    );
  }
}
