import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String name;

  @HiveField(1)
  bool isCompleted;

  @HiveField(2)
  String category;

  @HiveField(3)
  DateTime createdAt;

  Task({
    required this.name,
    this.isCompleted = false,
    this.category = 'Autres',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
