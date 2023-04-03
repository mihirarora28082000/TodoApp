import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/bloc/todo_bloc.dart';
import 'package:todoapp/data/models/task.dart';
import 'package:todoapp/presentation/widgets/alert_dialogue.dart';
import 'package:todoapp/presentation/widgets/snackbar.dart';

import 'package:todoapp/presentation/widgets/modal_bottom.dart';

import 'package:todoapp/data/scaling_query.dart';

class TaskCard extends StatefulWidget {
  final TodoTask task;

  const TaskCard({
    super.key,
    required this.task,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  Color color(int priority) {
    if (priority == 1) {
      return Colors.red;
    } else if (priority == 2) {
      return Colors.brown;
    }
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return !kIsWeb
        ? Dismissible(
            key: Key(widget.task.id.toString()),
            direction: DismissDirection.startToEnd,
            background: !widget.task.isCompleted
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
              context.read<TodoBloc>().add(ChangeTaskState(task: widget.task));
              !widget.task.isCompleted
                  ? snackBar(context, 'Task Marked as Completed !', true)
                  : snackBar(context, 'Task Marked as Incompleted !', false);
            },
            child: LayoutBuilder(builder: (context, constraints) {
              return Container(
                margin: const EdgeInsets.all(2.0),
                child: ListTile(
                  title: Text(
                    widget.task.name,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: ScalingQuery(context).fontSize(2)),
                  ),
                  subtitle: Text(
                    'Completion Date:  ${DateFormat('dd-MM-yyyy').format(widget.task.date)}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: ScalingQuery(context).fontSize(1.5)),
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (!widget.task.isCompleted)
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Theme.of(context).primaryColor,
                                size: ScalingQuery(context).fontSize(3),
                              ),
                              onPressed: () {
                                showModal(context, setState,
                                    descriptionText: widget.task.description,
                                    titleText: widget.task.name,
                                    sliderValueDefault:
                                        4 - widget.task.priority.toDouble(),
                                    idText: widget.task.id,
                                    dateInputText: widget.task.date);
                              },
                            ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: ScalingQuery(context).fontSize(3),
                            ),
                            onPressed: () async {
                              await showMyDialog(context,
                                      "Are you sure you want to delete this task ?")
                                  .then((value) {
                                if (value ?? false) {
                                  context
                                      .read<TodoBloc>()
                                      .add(DeleteTask(task: widget.task));
                                }
                              });
                            },
                          ),
                        ]),
                  ),
                  leading: widget.task.isCompleted == false
                      ? Icon(
                          Icons.today_outlined,
                          color: color(widget.task.priority),
                        )
                      : Icon(
                          Icons.task_alt,
                          color: color(widget.task.priority),
                        ),
                ),
              );
            }),
          )
        : LayoutBuilder(builder: (ctx, constraints) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(2.0),
              child: ListTile(
                title: Text(widget.task.name, overflow: TextOverflow.ellipsis),
                subtitle: Text(
                  widget.task.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                trailing: SizedBox(
                  width: constraints.maxWidth * 0.09,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                          value: widget.task.isCompleted,
                          onChanged: (change) {
                            context
                                .read<TodoBloc>()
                                .add(ChangeTaskState(task: widget.task));
                            !widget.task.isCompleted
                                ? snackBar(
                                    context, 'Task Marked as Completed !', true)
                                : snackBar(context,
                                    'Task Marked as InCompleted !', false);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await showMyDialog(context,
                                    'Are you sure you want to delete this task ?')
                                .then((value) {
                              if (value ?? false) {
                                context
                                    .read<TodoBloc>()
                                    .add(DeleteTask(task: widget.task));
                              }
                            });
                          },
                        )
                      ]),
                ),
                leading: widget.task.isCompleted == false
                    ? const Icon(Icons.today_outlined)
                    : const Icon(Icons.task_alt),
              ),
            );
          });
  }
}
