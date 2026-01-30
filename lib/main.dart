import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _nebulaPath = '';

  Future<void> _getNebulaPath() async {
    final cmd = await Process.run('which', ['nebula']);
    _nebulaPath = cmd.stdout.toString().trim();
    setState(() {});
  }

  Future<void> _launchNebula() async {
    if (_nebulaPath.isEmpty) {
      return;
    }
    final nebulaProcess = await Process.run('pkexec', [_nebulaPath]);
    print(nebulaProcess.stdout.toString());
    print(nebulaProcess.stderr.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('Nebula path:'),
            Text(
              _nebulaPath,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(onPressed: _nebulaPath.isEmpty ? null : _launchNebula, child: const Text('Launch Nebula')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getNebulaPath,
        tooltip: 'Get Nebula path',
        child: const Icon(Icons.add),
      ),
    );
  }
}
