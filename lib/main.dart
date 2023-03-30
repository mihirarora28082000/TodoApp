import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todoapp/bloc/todo_bloc.dart';
import 'package:todoapp/data/models/task.dart';
import 'package:todoapp/presentation/screen/todo_screen.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc()
        ..add(AddTask(
          task: TodoTask(
            id: '1',
            name: 'Drink Water',
            description: 'We should drink water for better performance',
            date: DateTime.now(),
            priority: 1,
          ),
        ))
        ..add(AddTask(
          task: TodoTask(
            id: '2',
            name: 'Drink Juice',
            description: 'We should drink Juice for better performance',
            date: DateTime.now(),
            priority: 2,
          ),
        )),
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          errorColor: Colors.red
        ),
        home: const TodoApp(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
