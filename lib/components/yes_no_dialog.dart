import 'package:flutter/material.dart';

class YesNoDialog extends StatelessWidget {
  final String title;
  final String content;
  const YesNoDialog({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: const Text('Yes'),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
        ),
        TextButton(
          child: const Text('No'),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
        ),
      ],
    );
  }
}
