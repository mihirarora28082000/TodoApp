import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoapp/data/models/task.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<AddTask>(_onAddTask);
    on<ChangeTaskState>(_onTaskStateChange);
    on<DeleteTask>(_onDeleteTask);
  }

  void _onAddTask(AddTask event, Emitter<TodoState> emit) {
    final state = this.state;
    emit(TodoState(
      outgoingTasks: List.from(state.outgoingTasks)
        ..add(event.task)
        ..sort((a, b) => a.priority.compareTo(b.priority)),
      completedTasks: this.state.completedTasks,
    ));
  }

  void _onTaskStateChange(ChangeTaskState event, Emitter<TodoState> emit) {
    final state = this.state;
    final task = event.task;
    List<TodoTask> outgoingTasks = state.outgoingTasks;
    List<TodoTask> completedTasks = state.completedTasks;
    task.isCompleted == false
        ? {
            completedTasks = List.from(completedTasks)
              ..insert(0, task.copyWith(isCompleted: true)),
            outgoingTasks = List.from(outgoingTasks)..remove(task)
          }
        : {
            outgoingTasks = List.from(outgoingTasks)
              ..insert(0, task.copyWith(isCompleted: false)),
            completedTasks = List.from(completedTasks)..remove(task)
          };
    emit(TodoState(
        outgoingTasks: outgoingTasks, completedTasks: completedTasks));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TodoState> emit) {
    final task = event.task;

    emit(TodoState(
        outgoingTasks: List.from(this.state.outgoingTasks)..remove(task),
        completedTasks: List.from(this.state.completedTasks)..remove(task)));
  }
}
