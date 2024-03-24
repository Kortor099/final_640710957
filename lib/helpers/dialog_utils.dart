import 'package:flutter/material.dart';

Future showOkDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String url,
  required String description,
  required String type,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Column(
          children: [
            Text(message),
            Text('URL: $url'),
            Text('Description: $description'),
            Text('Type: $type'),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    },
  );
}
