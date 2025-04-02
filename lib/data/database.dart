import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];
  //reference a ma box HIVE
  final _mybox = Hive.box('mybox');
  //lancer  cette methode a la premiere ouverture de l'app
  void createInitialData() {
    toDoList = [
      ["ranger la chambre", false],
      ["faire les courses", true]
    ];
  }

  //charger les donnees  depuis  la  base de donnees
  void loadData() {
    toDoList = _mybox.get("TODOLIST");
  }

  // mettre a jourla base de donnees
  void updateDatabase() {
    _mybox.put("TODOLIST", toDoList);
  }
}
