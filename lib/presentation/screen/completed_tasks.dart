import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todoapp/data/models/task.dart';
import 'package:todoapp/bloc/todo_bloc.dart';
import 'package:todoapp/presentation/widgets/task_card.dart';

class CompletedTasks extends StatefulWidget {
  const CompletedTasks({super.key});

  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        List<TodoTask> taskList = state.completedTasks;
        return taskList.isEmpty
            ? const Center(child: Text('No Completed Tasks'))
            : ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(5),
                      child: TaskCard(task: taskList[index]),
                    ),
                  );
                });
      },
    );
  }
}
