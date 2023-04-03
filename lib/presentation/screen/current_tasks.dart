import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todoapp/data/models/task.dart';
import 'package:todoapp/bloc/todo_bloc.dart';
import 'package:todoapp/presentation/widgets/task_card.dart';

class OutgoingTasks extends StatefulWidget {
  const OutgoingTasks({super.key});

  @override
  State<OutgoingTasks> createState() => _OutgoingTasksState();
}

class _OutgoingTasksState extends State<OutgoingTasks> {
  Color color(int priority) {
    if (priority == 1) {
      return Colors.red;
    } else if (priority == 2) {
      return Colors.brown;
    }
    return Colors.green;
  }

  LinearGradient bodercolor(TodoTask task) {
    return LinearGradient(
      stops: const [0.02, 0.02],
      colors: [color(task.priority), Colors.white],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        List<TodoTask> taskList = state.outgoingTasks;
        return taskList.isEmpty
            ? const Center(child: Text('No Outgoing Tasks'))
            : ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (ctx, index) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          gradient: bodercolor(taskList[index]),
                          borderRadius: BorderRadius.circular(29)),
                      child: Card(
                        child: TaskCard(task: taskList[index]),
                      ));
                });
      },
    );
  }
}
