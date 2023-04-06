import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:todoapp/data/models/task.dart';
import 'package:todoapp/presentation/bloc/todo_bloc.dart';
import 'package:todoapp/presentation/constants/colors.dart';
import 'package:todoapp/presentation/constants/label_names.dart';
import 'package:todoapp/presentation/utils/task_priority_color.dart';
import 'package:todoapp/presentation/widgets/alert_dialogue.dart';
import 'package:todoapp/presentation/utils/snackbar.dart';
import 'package:todoapp/presentation/widgets/icon_button.dart';
import 'package:todoapp/presentation/widgets/modal_bottom.dart';
import 'package:todoapp/presentation/constants/icons.dart';
import 'package:todoapp/presentation/utils/scaling_query.dart';

class TaskCard extends StatefulWidget {
  final TodoTask task;

  const TaskCard({super.key, required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  IconTaskButton deleteTask() {
    return IconTaskButton(
        icon: deleteTaskIcon,
        iconColor: Theme.of(context).colorScheme.error,
        iconSize: ScalingQuery(context).fontSize(3),
        onpressedIcon: () async {
          await showMyDialog(context, ALERT_BOX_ON_DELETE_TASK).then((value) {
            if (value ?? false) {
              context.read<TodoBloc>().add(DeleteTask(task: widget.task));
            }
          });
        });
  }

  Checkbox checkBoxWeb() {
    return Checkbox(
        value: widget.task.isCompleted,
        onChanged: (change) {
          context.read<TodoBloc>().add(ChangeTaskState(task: widget.task));
          !widget.task.isCompleted
              ? snackBar(context, SNACK_BAR_ON_TASK_COMPLETE, true)
              : snackBar(context, SNACK_BAR_ON_TASK_INCOMPLETE, false);
        });
  }

  IconTaskButton editMyTask() {
    return IconTaskButton(
        icon: editTask,
        iconColor: Theme.of(context).primaryColor,
        iconSize: ScalingQuery(context).fontSize(3),
        onpressedIcon: () {
          showModal(context, setState,
              descriptionText: widget.task.description,
              titleText: widget.task.name,
              sliderValueDefault: widget.task.priority.toDouble(),
              idText: widget.task.id,
              dateInputText: widget.task.date);
        });
  }

  @override
  Widget build(BuildContext context) {
    return !kIsWeb
        ? Dismissible(
            key: Key(widget.task.id.toString()),
            direction: DismissDirection.startToEnd,
            background: !widget.task.isCompleted
                ? Container(
                    color: green,
                    child: const Icon(Icons.task, color: white, size: 30))
                : Container(
                    color: Theme.of(context).colorScheme.error,
                    child: const Icon(Icons.today_outlined,
                        color: Colors.white, size: 30)),
            onDismissed: (direction) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              context.read<TodoBloc>().add(ChangeTaskState(task: widget.task));
              !widget.task.isCompleted
                  ? snackBar(context, SNACK_BAR_ON_TASK_COMPLETE, true)
                  : snackBar(context, SNACK_BAR_ON_TASK_INCOMPLETE, false);
            },
            child: LayoutBuilder(builder: (context, constraints) {
              return Container(
                  margin: const EdgeInsets.all(2.0),
                  child: ListTile(
                      title: Text(widget.task.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: ScalingQuery(context).fontSize(2))),
                      subtitle: Text(
                          '$DATE_COMPLETED  ${DateFormat('dd-MM-yyyy').format(widget.task.date)}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: ScalingQuery(context).fontSize(1.5))),
                      trailing: SizedBox(
                          width: 100,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (!widget.task.isCompleted) editMyTask(),
                                deleteTask()
                              ])),
                      leading: widget.task.isCompleted == false
                          ? IconTaskButton(
                              icon: currentTaskIcon,
                              onpressedIcon: () {},
                              iconColor:
                                  taskPriorityColor(widget.task.priority),
                            )
                          : IconTaskButton(
                              icon: completedTaskIcon,
                              onpressedIcon: () {},
                              iconColor:
                                  taskPriorityColor(widget.task.priority),
                            )));
            }))
        : LayoutBuilder(builder: (ctx, constraints) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(2.0),
                child: ListTile(
                    title:
                        Text(widget.task.name, overflow: TextOverflow.ellipsis),
                    subtitle: Text(widget.task.description,
                        overflow: TextOverflow.ellipsis, maxLines: 2),
                    trailing: SizedBox(
                        width: constraints.maxWidth * 0.09,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [checkBoxWeb(), deleteTask()])),
                    leading: widget.task.isCompleted == false
                        ? const Icon(currentTaskIcon)
                        : const Icon(completedTaskIcon)));
          });
  }
}
