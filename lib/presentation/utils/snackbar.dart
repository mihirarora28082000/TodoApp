import 'package:flutter/material.dart';

import 'package:todoapp/presentation/constants/colors.dart';

void snackBar(BuildContext context, String message, bool isCompleted) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    
      backgroundColor:
          isCompleted ? green : Theme.of(context).colorScheme.error,
      duration: const Duration(seconds: 1),
      content: Text(message)));
}
