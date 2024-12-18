import 'package:flutter/material.dart';

class QRCodePage extends StatelessWidget {
  final String userId;

  const QRCodePage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('QR Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Simulated QR code using a container with a border
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text('QR Code'),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Scan this QR Code to connect:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              userId,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () {
                // Simulate scanning process
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Scan Result'),
                    content: Text('Scanned data: $userId'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Share QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}