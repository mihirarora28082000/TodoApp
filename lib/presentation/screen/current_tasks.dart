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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        List<TodoTask> taskList = state.outgoingTasks;
        return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (ctx, index) {
              return Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(5),
                  child: TaskCard(
                    task:taskList[index]
                  ),
                ),
              );
            });
      },
    );
  }
}
