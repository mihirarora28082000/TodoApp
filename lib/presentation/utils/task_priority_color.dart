import 'package:flutter/material.dart';
import 'package:todoapp/presentation/constants/colors.dart';
import 'package:todoapp/presentation/constants/label_names.dart';

Color taskPriorityColor(int priority) {
  if (priority == HIGH_TASK_PRIORITY) {
    return red;
  } else if (priority == MEDIUM_TASK_PRIORITY) {
    return brown;
  }
  return green;
}
