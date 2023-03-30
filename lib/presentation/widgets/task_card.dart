import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todoapp/bloc/todo_bloc.dart';
import 'package:todoapp/data/models/task.dart';
import 'package:todoapp/presentation/widgets/alert_dialogue.dart';
import 'package:todoapp/presentation/widgets/snackbar.dart';

class TaskCard extends StatelessWidget {
  final TodoTask task;

  const TaskCard({
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return !kIsWeb
        ? Dismissible(
            key: Key(task.id.toString()),
            direction: DismissDirection.startToEnd,
            background: !task.isCompleted
                ? Container(
                    color: Colors.green,
                    child: const Icon(
                      Icons.task,
                      color: Colors.white,
                      size: 30,
                    ),
                  )
                : Container(
                    color: Colors.red,
                    child: const Icon(
                      Icons.today_outlined,
                      color: Colors.white,
                      size: 30,
                    )),
            onDismissed: (direction) {
              context.read<TodoBloc>().add(ChangeTaskState(task: task));
              !task.isCompleted
                  ? snackBar(context, 'Task Marked as Completed !', true)
                  : snackBar(context, 'Task Marked as Incompleted !', false);
            },
            child: Container(
              margin: const EdgeInsets.all(2.0),
              child: ListTile(
                title: Text(task.name, overflow: TextOverflow.ellipsis),
                subtitle: Text(
                  task.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await showMyDialog(context).then((value) {
                      if (value ?? false) {
                        context.read<TodoBloc>().add(DeleteTask(task: task));
                      }
                    });
                  },
                ),
                leading: task.isCompleted == false
                    ? const Icon(Icons.today_outlined)
                    : const Icon(Icons.task_alt),
              ),
            ),
          )
        : LayoutBuilder(builder: (ctx, constraints) {
            return Container(
              margin: const EdgeInsets.all(2.0),
              child: ListTile(
                title: Text(task.name, overflow: TextOverflow.ellipsis),
                subtitle: Text(
                  task.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                trailing: SizedBox(
                  width: constraints.maxWidth * 0.09,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                          value: task.isCompleted,
                          onChanged: (change) {
                            context
                                .read<TodoBloc>()
                                .add(ChangeTaskState(task: task));
                            !task.isCompleted
                                ? snackBar(
                                    context, 'Task Marked as Completed !', true)
                                : snackBar(context,
                                    'Task Marked as InCompleted !', false);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await showMyDialog(context).then((value) {
                              if (value ?? false) {
                                context
                                    .read<TodoBloc>()
                                    .add(DeleteTask(task: task));
                              }
                            });
                          },
                        )
                      ]),
                ),
                leading: task.isCompleted == false
                    ? const Icon(Icons.today_outlined)
                    : const Icon(Icons.task_alt),
              ),
            );
          });
  }
}
