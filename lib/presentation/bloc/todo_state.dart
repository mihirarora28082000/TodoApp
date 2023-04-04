part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final List<TodoTask> outgoingTasks;
  final List<TodoTask> completedTasks;
  const TodoState(
      {this.completedTasks = const <TodoTask>[],
      this.outgoingTasks = const <TodoTask>[]});

  @override
  List<Object> get props => [completedTasks, outgoingTasks];

  Map<String, dynamic> toMap() {
    return {
      'outgoingTasks': outgoingTasks.map((x) => x.toMap()).toList(),
      'completedTasks': completedTasks.map((x) => x.toMap()).toList()
    };
  }

  factory TodoState.fromMap(Map<String, dynamic> map) {
    return TodoState(
        outgoingTasks: List<TodoTask>.from(
            map['outgoingTasks']?.map((x) => TodoTask.fromMap(x))),
        completedTasks: List<TodoTask>.from(
            map['completedTasks']?.map((x) => TodoTask.fromMap(x))));
  }
}
