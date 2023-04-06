import 'package:todoapp/core/usecase.dart';
import 'package:todoapp/data/models/task.dart';
import 'package:todoapp/domain/repositories/todo_repository.dart';


class Params {
  final TodoTask todo;
  Params({
    required this.todo,
  });
}

class AddTodoUseCase extends UseCase<void,Params>{
   final TodoRepository repository;

  AddTodoUseCase(this.repository);
  
  @override
  void call(params) {
    return repository.addTodo(params.todo);
  }
}
