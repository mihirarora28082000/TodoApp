part of 'todo_bloc.dart';


class TodoState extends Equatable {
  final List<TodoTask> outgoingTasks;
  final List<TodoTask> completedTasks;
  const TodoState(
      {this.completedTasks = const <TodoTask>[],
      this.outgoingTasks = const <TodoTask>[]});

  @override
  List<Object> get props => [completedTasks, outgoingTasks];
}
