import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/presentation/bloc/todo_bloc.dart';
import 'package:todoapp/presentation/constants/colors.dart';
import 'package:todoapp/presentation/constants/label_names.dart';
import 'package:todoapp/presentation/constants/icons.dart';
import 'package:todoapp/presentation/screen/completed_tasks.dart';
import 'package:todoapp/presentation/screen/current_tasks.dart';
import 'package:todoapp/presentation/widgets/modal_bottom.dart';

import 'package:todoapp/presentation/widgets/alert_dialogue.dart';
import 'package:todoapp/data/scaling_query.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  int _currentPageIndex = OUTGOING_TASKS_PAGE;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Flushbar(
              icon: const Icon(Icons.error, color: blue),
              flushbarPosition: FlushbarPosition.TOP,
              title: FLUSHBAR_TODO_SCREEN_TITLE,
              messageSize: ScalingQuery(context).fontSize(1.7),
              message: FLUSHBAR_TODO_SCREEN_MESSAGE)
          .show(context);

      super.initState();
    });
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(APP_TITLE),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                showMyDialog(context, ALERT_DELETE_ALL_TASKS).then((value) {
                  if (value == true) {
                    context.read<TodoBloc>().add(DeleteAllTasks());
                  }
                });
              },
              child: Text(DELETE_ALL_TASKS,
                  style:
                      TextStyle(fontSize: ScalingQuery(context).fontSize(1.7))))
        ]);
  }

  BottomNavigationBar _bottomNavigationaBar(context) {
    return BottomNavigationBar(
        showUnselectedLabels: false,
        backgroundColor: Theme.of(context).primaryColor,
        onTap: (index) => _onDestinationSelected(index),
        selectedItemColor: white,
        currentIndex: _currentPageIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(currentTaskIcon, color: white), label: OUTGOING_TASKS),
          BottomNavigationBarItem(
              icon: Icon(completedTaskIcon, color: white),
              label: COMPLETED_TASKS)
        ]);
  }

  FloatingActionButton? _floatingActionButton() {
    return FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showModal(context, setState);
        },
        child: addTaskIcon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _floatingActionButton(),
        appBar: _appBar(context),
        bottomNavigationBar: _bottomNavigationaBar(context),
        body: const [OutgoingTasks(), CompletedTasks()][_currentPageIndex]);
  }
}
