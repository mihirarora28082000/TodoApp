import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todoapp/data/models/task.dart';
import 'package:todoapp/presentation/bloc/todo_bloc.dart';
import 'package:todoapp/presentation/constants/colors.dart';
import 'package:todoapp/presentation/constants/label_names.dart';
import 'package:todoapp/presentation/utils/task_priority_color.dart';
import 'package:todoapp/presentation/widgets/task_card.dart';

class OutgoingTasks extends StatefulWidget {
  const OutgoingTasks({super.key});

  @override
  State<OutgoingTasks> createState() => _OutgoingTasksState();
}

class _OutgoingTasksState extends State<OutgoingTasks> {
  LinearGradient bodercolor(TodoTask task) {
    return LinearGradient(
        stops: const [0.02, 0.02],
        colors: [taskPriorityColor(task.priority), white]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
      List<TodoTask> taskList = state.outgoingTasks;
      return taskList.isEmpty
          ? const Center(child: Text(NO_OUTGOING_TASKS))
          : ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (ctx, index) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        gradient: bodercolor(taskList[index]),
                        borderRadius: BorderRadius.circular(29)),
                    child: Card(child: TaskCard(task: taskList[index])));
              });
    });
  }
}
