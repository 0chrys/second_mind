import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:second_mind/page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialiser HIVE
  await Hive.initFlutter();
  //ouvrir  une box
  var box = await Hive.openBox('mybox');
  // Lire et afficher le contenu de la boîte
  box.toMap().forEach((key, value) {
    print('Clé: $key, Valeur: $value');
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          appBarTheme: AppBarTheme(color: Colors.lightBlue)),
    );
  }
}
