import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class Todo extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String createdAt;
  @HiveField(4)
  final String? status;
  Todo({
    required this.title,
    required this.description,
    required this.createdAt,
    this.status,
  }) : id = const Uuid().v4();

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    String? createdAt,
    String? status,
  }) {
    return Todo(
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }
}
