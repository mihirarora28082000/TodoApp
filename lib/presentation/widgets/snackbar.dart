import 'package:flutter/material.dart';

void snackBar(BuildContext context, String message, bool isCompleted) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: isCompleted ? Colors.green : Colors.red,
      duration: const Duration(seconds: 1),
      content: Text(message),
    ),
  );
}
