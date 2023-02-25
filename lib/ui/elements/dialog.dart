// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  String dialogText;

  ConfirmDialog({required this.dialogText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(dialogText),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Yes")),
        TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("No"))
      ],
    );
  }
}