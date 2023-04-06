import 'package:todoapp/presentation/constants/label_names.dart';

String labelSlider(int priority) {
  if (priority == LOW_TASK_PRIORITY) {
    return PRIORITY_LOW;
  } else if (priority == MEDIUM_TASK_PRIORITY) {
    return PRIORITY_MID;
  } else {
    return PRIORITY_HIGH;
  }
}
