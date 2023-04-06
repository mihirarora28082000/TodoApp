import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoapp/presentation/bloc/todo_bloc.dart';
import 'package:todoapp/presentation/constants/label_names.dart';
import 'package:todoapp/presentation/screen/home_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  if (!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: await getApplicationDocumentsDirectory());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TodoBloc(),
        child: MaterialApp(
            title: APP_TITLE,
            theme: ThemeData.light().copyWith(
              buttonColor: Colors.purple,
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.purple,
                errorColor: Colors.red,
                accentColor: Colors.yellow,
              ),
              inputDecorationTheme: const InputDecorationTheme(
                  labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        style: BorderStyle.solid, color: Colors.grey),
                  )),
              primaryColor: Colors.purple,
            ),
            debugShowCheckedModeBanner: false,
            home: const HomeScreen()));
  }
}
