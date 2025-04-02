import 'package:flutter/material.dart';
import 'package:second_mind/utils/my_button.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.lightBlue,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //recuperer les donnees a partir de l'utilisateur
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "ajouter une  nouvelle tache"),
            ),
            //les boutons sauvegarder et quitter
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //sauvegarder
                MyButton(text: "sauvegarder", onPressed: onSave),
                SizedBox(
                  width: 4,
                ),
                //quitter
                MyButton(text: "annuler", onPressed: onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}
