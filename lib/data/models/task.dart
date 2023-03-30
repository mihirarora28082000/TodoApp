import 'package:equatable/equatable.dart';


class TodoTask extends Equatable {
  final String id;
  final String name;
  final String description;
  final DateTime date;
  final int priority;
  final bool isCompleted;

  const TodoTask(
      {required this.id,
      required this.description,
      required this.name,
      required this.date,
      required this.priority,
      this.isCompleted = false});

  @override
  List<Object?> get props =>
      [id, description, name, date, priority, isCompleted];

  TodoTask copyWith({
     String? id,
     String? name,
     String? description,
     DateTime? date,
     int? priority,
     bool? isCompleted,
  }) {
    return TodoTask(
        id: id ?? this.id,
        description: description ?? this.description,
        name: name ?? this.name,
        date: date ?? this.date,
        priority: priority ?? this.priority,
        isCompleted: isCompleted ?? this.isCompleted,
        );
  }
}
