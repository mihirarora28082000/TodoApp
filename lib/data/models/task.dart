import 'package:todoapp/domain/entities/todo_entity.dart';

class TodoTask extends TodoEntity {
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
      required this.isCompleted})
      : super(
            id: id,
            description: description,
            name: name,
            date: date,
            priority: priority,
            isCompleted: isCompleted);

  TodoTask copyWith(
      {String? name,
      String? description,
      DateTime? date,
      int? priority,
      bool? isCompleted}) {
    return TodoTask(
        id: id,
        description: description ?? this.description,
        name: name ?? this.name,
        date: date ?? this.date,
        priority: priority ?? this.priority,
        isCompleted: isCompleted ?? this.isCompleted);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'date': date.toIso8601String(),
      'priority': priority,
      'isCompleted': isCompleted
    };
  }

  factory TodoTask.fromMap(Map<String, dynamic> map) {
    return TodoTask(
        id: map['id'],
        description: map['description'],
        name: map['name'],
        date: DateTime.parse(map['date']),
        priority: map['priority'],
        isCompleted: map['isCompleted']);
  }
}
