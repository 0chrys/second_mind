import 'package:flutter/material.dart';
import 'package:second_mind/data/database.dart';
import 'package:second_mind/models/tasks.dart';
import 'package:second_mind/utils/my_button.dart';

class DialogBox extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final Task? task;
  final String? selectedCategory;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    this.task,
    this.selectedCategory,
  });

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  String? _selectedCategory;
  late final ToDoDatabase _db;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory ?? 'Autres';
    _db = ToDoDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: widget.task != null
                    ? 'Modifier la tâche'
                    : 'Ajouter une nouvelle tâche',
                filled: true,
                fillColor: Theme.of(context).cardColor,
              ),
            ),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
              ),
              items: _db.categories.map((category) {
                return DropdownMenuItem(
                  value: category.name,
                  child: Row(
                    children: [
                      Icon(category.icon, color: category.color),
                      const SizedBox(width: 8),
                      Text(category.name),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
              isExpanded: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  text: widget.task != null ? 'Modifier' : 'Sauvegarder',
                  onPressed: widget.onSave,
                  isOutlined: true,
                ),
                const SizedBox(width: 4),
                MyButton(
                  text: 'Annuler',
                  onPressed: widget.onCancel,
                  isOutlined: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
