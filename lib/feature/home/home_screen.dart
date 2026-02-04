import 'package:flutter/material.dart';
import 'package:nebula_ui/app/routing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nebula UI'),
        actions: [
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, AppRouter.preferences),
          ),
        ],
      ),
      body: const Placeholder(),
    );
  }
}