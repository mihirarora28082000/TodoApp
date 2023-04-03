import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/presentation/screen/completed_tasks.dart';
import 'package:todoapp/presentation/screen/current_tasks.dart';
import 'package:todoapp/presentation/widgets/modal_bottom.dart';

import 'package:todoapp/bloc/todo_bloc.dart';
import 'package:todoapp/presentation/widgets/alert_dialogue.dart';
import 'package:todoapp/data/scaling_query.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  int _currentPageIndex = 0;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Flushbar(
        icon: const Icon(Icons.error, color: Colors.blue),
        flushbarPosition: FlushbarPosition.TOP,
        title: "TODO App",
        messageSize: ScalingQuery(context).fontSize(1.7),
        message:
            "Welcome to Todo App.\nHere you can create your TODOs. Whenever a task gets completed you can swipe them right. Swipe up this message to continue.",
      ).show(context);

      super.initState();
    });
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModal(context, setState);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Todo App'),
        actions: [
          ElevatedButton(
            onPressed: () {
              showMyDialog(context,
                      "Are you sure you want to delete all Outgoing and Completed tasks ?")
                  .then((value) {
                if (value == true) {
                  context.read<TodoBloc>().add(DeleteAllTasks());
                }
              });
            },
            child: Text('DELETE ALL TASKS',
                style: TextStyle(
                    fontSize:ScalingQuery(context).fontSize(1.7))),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        backgroundColor: Theme.of(context).primaryColor,
        onTap: (index) => _onDestinationSelected(index),
        selectedItemColor: Colors.white,
        currentIndex: _currentPageIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.today_outlined,
                color: Colors.white,
              ),
              label: 'Outgoing Tasks'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.task_alt,
                color: Colors.white,
              ),
              label: 'Completed Tasks'),
        ],
      ),
      body: const [OutgoingTasks(), CompletedTasks()][_currentPageIndex],
    );
  }
}
