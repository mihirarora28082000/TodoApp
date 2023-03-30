import 'package:flutter/material.dart';

import 'package:todoapp/presentation/screen/completed_tasks.dart';
import 'package:todoapp/presentation/screen/current_tasks.dart';


class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  int _currentPageIndex = 0;
  void _onDestinationSelected(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Todo App'),
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
