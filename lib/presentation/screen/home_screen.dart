import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todoapp/presentation/constants/label_names.dart';
import 'package:todoapp/presentation/screen/todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  AppBar _appBarHomeScreen(BuildContext context) {
    return AppBar(
      title: const Text(WELCOME_TITLE_HOME_SCREEN),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  ElevatedButton onSubmit(BuildContext context, Size screenSize) {
    return ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (ctx) => const TodoApp()));
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ))),
        child: Container(
            width: screenSize.width * 0.4,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              color: Theme.of(context).primaryColor,
            ),
            child: const Center(child: Text(SCHEDULE_TASKS))));
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: _appBarHomeScreen(context),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
              child: SvgPicture.asset('lib/presentation/images/todo.svg',
                  width: screenSize.width * 0.5,
                  height: screenSize.height * 0.5)),
          SizedBox(height: screenSize.height * 0.1),
          onSubmit(context, screenSize)
        ]));
  }
}
