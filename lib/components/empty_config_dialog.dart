import 'package:flutter/material.dart';

class EmptyConfigDialog extends StatelessWidget {
  const EmptyConfigDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Config is empty'),
      content: Text(
        'Looks like there\'s first app launch.\n Would you like to set it up?',
      ),
      actions: [
        TextButton(
          child: const Text('Yes'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        TextButton(
          child: const Text('No'),
          onPressed: () => Navigator.pop(context, false),
        ),
      ],
    );
  }
}
