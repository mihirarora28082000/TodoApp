import 'package:todoapp/data/models/task.dart';
import 'package:todoapp/domain/repositories/todo_repository.dart';

class TodoRepositoryImp extends TodoRepository {
  @override
  void addTodo(TodoTask todo) {}

  @override
  void changeTodoState(TodoTask todo) {}

  @override
  void deleteAllTodos() {}

  @override
  void deleteTodo(TodoTask todo) {}

  @override
  void editTodo(TodoTask todo) {}

  @override
  List<TodoTask> getAllTodos() {
    throw UnimplementedError();
  }
}
