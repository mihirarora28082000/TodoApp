import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todoapp/presentation/screen/todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Todo App'),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: SvgPicture.asset(
              'lib/images/todo.svg',
              width: screenSize.width * 0.5,
              height: screenSize.height * 0.5,
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.1,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) => const TodoApp()));
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              child: Container(
                  width: screenSize.width * 0.4,
                  padding: const EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(90)),
                  child: const Center(child: Text('SCHEDULE TASK')))),
        ]));
  }
}
