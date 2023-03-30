part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class AddTask extends TodoEvent{
  final TodoTask task;

  const AddTask({required this.task });

  @override
  List<Object> get props => [task];
}

class ChangeTaskState extends TodoEvent{
  final TodoTask task;

  const ChangeTaskState({required this.task });

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TodoEvent{
  final TodoTask task;

  const DeleteTask({required this.task });

  @override
  List<Object> get props => [task];
}
