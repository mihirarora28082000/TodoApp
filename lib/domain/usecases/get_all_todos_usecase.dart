import 'package:todoapp/core/usecase.dart';
import 'package:todoapp/data/models/task.dart';
import 'package:todoapp/domain/repositories/todo_repository.dart';

class Params {}

class GetAllTodos extends UseCase<List<TodoTask>, Params> {
  final TodoRepository repository;

  GetAllTodos(this.repository);

  @override
  List<TodoTask> call(params) {
    return repository.getAllTodos();
  }
}
