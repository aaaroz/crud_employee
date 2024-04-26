import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "My App",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Center(
        child: Text("Hello World!"),
      ),
    );
  }
}
