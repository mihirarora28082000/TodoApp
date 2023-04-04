import 'package:todoapp/core/usecase.dart';
import 'package:todoapp/domain/repositories/todo_repository.dart';

class Params {}

class DeleteAllTodosUsecase extends UseCase<void, Params> {
  final TodoRepository repository;

  DeleteAllTodosUsecase(this.repository);

  @override
  void call(params) {
    return repository.deleteAllTodos();
  }
}
