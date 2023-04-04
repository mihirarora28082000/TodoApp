import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:todoapp/data/models/task.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends HydratedBloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<AddTask>(_onAddTask);
    on<ChangeTaskState>(_onTaskStateChange);
    on<DeleteTask>(_onDeleteTask);
    on<DeleteAllTasks>(_deleteAllTasks);
  }

  void _onAddTask(AddTask event, Emitter<TodoState> emit) async {
    final state = this.state;

    List<TodoTask> outgoingTasks = state.outgoingTasks;
    List<TodoTask> completedTasks = state.completedTasks;
    outgoingTasks = List.from(state.outgoingTasks)
      ..removeWhere((task) => ((task.id) == (event.task.id)))
      ..add(event.task)
      ..sort((a, b) => a.date.compareTo(b.date));
    completedTasks = this.state.completedTasks;
    emit(TodoState(
        outgoingTasks: outgoingTasks, completedTasks: completedTasks));
  }

  void _onTaskStateChange(
      ChangeTaskState event, Emitter<TodoState> emit) async {
    final state = this.state;
    final task = event.task;
    List<TodoTask> outgoingTasks = state.outgoingTasks;
    List<TodoTask> completedTasks = state.completedTasks;
    task.isCompleted == false
        ? {
            completedTasks = List.from(completedTasks)
              ..add(task.copyWith(isCompleted: true))
              ..sort((a, b) => a.date.compareTo(b.date)),
            outgoingTasks = List.from(outgoingTasks)..remove(task)
          }
        : {
            outgoingTasks = List.from(outgoingTasks)
              ..add(task.copyWith(isCompleted: false))
              ..sort((a, b) => a.date.compareTo(b.date)),
            completedTasks = List.from(completedTasks)..remove(task)
          };
    emit(TodoState(
        outgoingTasks: outgoingTasks, completedTasks: completedTasks));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TodoState> emit) async {
    final task = event.task;
    List<TodoTask> outgoingTasks = state.outgoingTasks;
    List<TodoTask> completedTasks = state.completedTasks;
    if (task.isCompleted) {
      completedTasks = List.from(completedTasks)..remove(task);
    } else {
      outgoingTasks = List.from(outgoingTasks)..remove(task);
    }

    emit(TodoState(
        outgoingTasks: outgoingTasks, completedTasks: completedTasks));
  }

  void _deleteAllTasks(DeleteAllTasks event, Emitter<TodoState> emit) async {
    emit(const TodoState());
  }

  @override
  TodoState? fromJson(Map<String, dynamic> json) {
    return TodoState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TodoState state) {
    return state.toMap();
  }
}
