import 'package:flutter/material.dart';
import '../PesanPage.dart';
import '../PesananPage.dart';

class MainPage extends StatelessWidget {
  final String userName;
  final String userId;

  const MainPage({super.key, required this.userName, required this.userId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Hello, $userName!'), // Menyapa pengguna
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pesan'),   // Tab pertama untuk PesanPage
              Tab(text: 'Pesanan'), // Tab kedua untuk PesananPage
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PesanPage(userId: userId),   // Menggunakan userId di PesanPage
            PesananPage(userId: userId), // Menggunakan userId di PesananPage
          ],
        ),
      ),
    );
  }
}
