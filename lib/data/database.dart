import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:second_mind/models/tasks.dart';
import 'package:second_mind/taskcategory.dart';

class ToDoDatabase {
  List<Task> toDoList = [];
  final _mybox = Hive.box('mybox');

  // Initialiser les catégories
  final List<TaskCategory> categories = [
    TaskCategory(
      name: 'Personnel',
      color: Colors.blue,
      icon: Icons.person,
    ),
    TaskCategory(
      name: 'Travail',
      color: Colors.purple,
      icon: Icons.work,
    ),
    TaskCategory(
      name: 'Courses',
      color: Colors.green,
      icon: Icons.shopping_cart,
    ),
    TaskCategory(
      name: 'Autres',
      color: Colors.orange,
      icon: Icons.more_horiz,
    ),
  ];

  void createInitialData() {
    toDoList = [
      Task(
        name: "ranger la chambre",
        isCompleted: false,
        category: "Personnel",
      ),
      Task(
        name: "faire les courses",
        isCompleted: true,
        category: "Courses",
      ),
    ];
  }

  void loadData() async {
    List<dynamic>? data = await _mybox.get("TODOLIST");
    if (data != null) {
      toDoList = data
          .map((task) => Task(
                name: task['name'],
                isCompleted: task['isCompleted'],
                category: task['category'],
                createdAt: DateTime.parse(task['createdAt']),
              ))
          .toList();
    }
  }

  void updateDatabase() async {
    await _mybox.put(
      "TODOLIST",
      toDoList
          .map((task) => {
                'name': task.name,
                'isCompleted': task.isCompleted,
                'category': task.category,
                'createdAt': task.createdAt.toIso8601String(),
              })
          .toList(),
    );
  }
}
