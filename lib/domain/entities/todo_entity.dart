import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final DateTime date;
  final int priority;
  final bool isCompleted;

  const TodoEntity(
      {required this.id,
      required this.description,
      required this.name,
      required this.date,
      required this.priority,
      required this.isCompleted});

  @override
  List<Object?> get props =>
      [id, description, name, date, priority, isCompleted];

}
