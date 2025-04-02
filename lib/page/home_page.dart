import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:second_mind/data/database.dart';
import 'package:second_mind/models/tasks.dart';
import 'package:second_mind/theme_provider.dart';
import 'package:second_mind/utils/dialog_box.dart';
import 'package:second_mind/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox = Hive.box('mybox');
  final _controller = TextEditingController();
  late ToDoDatabase db;
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    db = ToDoDatabase();
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    setState(() {
      _isLoading = false;
    });
  }

  // Filtrer les tâches
  List<Task> get filteredTasks {
    if (_searchQuery.isEmpty) return db.toDoList;
    return db.toDoList
        .where((task) =>
            task.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  // Checkbox callback
  void checkBoxChanged(bool? value, Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
      db.updateDatabase();
    });
  }

  // Sauvegarder une nouvelle tâche
  void saveNewTask() {
    setState(() {
      db.toDoList.add(Task(
        name: _controller.text,
        isCompleted: false,
        category: 'Autres',
      ));
      _controller.clear();
      db.updateDatabase();
    });
    Navigator.of(context).pop();
  }

  // Créer une nouvelle tâche
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // Supprimer une tâche
  void deleteTask(Task task) {
    setState(() {
      db.toDoList.remove(task);
      db.updateDatabase();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("SECOND MIND"),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher une tâche...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          // Liste des tâches
          Expanded(
            child: ListView.builder(
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                return TodoTile(
                  task: filteredTasks[index],
                  onChanged: (value) =>
                      checkBoxChanged(value, filteredTasks[index]),
                  deleteFunction: (context) => deleteTask(filteredTasks[index]),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
