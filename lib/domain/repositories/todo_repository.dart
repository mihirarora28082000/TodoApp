import 'package:todoapp/data/models/task.dart';

abstract class TodoRepository {
  void addTodo(TodoTask todo);
  void changeTodoState(TodoTask todo);
  void editTodo(TodoTask todo);
  void deleteTodo(TodoTask todo);
  List<TodoTask> getAllTodos();
  void deleteAllTodos();
}
