import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Couleurs du thème clair
  ThemeData get lightTheme => ThemeData(
        primaryColor: const Color(0xFF2196F3), // Bleu vif
        secondaryHeaderColor: const Color(0xFF1976D2), // Bleu plus foncé
        scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Gris très clair
        appBarTheme: AppBarTheme(
          color: const Color(0xFF2196F3),
          elevation: 0,
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(const Color(0xFF1976D2)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
          titleLarge: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color(0xFF1976D2),
          foregroundColor: Colors.white,
        ),
      );

  // Couleurs du thème sombre
  ThemeData get darkTheme => ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF1E88E5), // Bleu plus clair en mode sombre
        scaffoldBackgroundColor: const Color(0xFF121212), // Noir profond
        appBarTheme: AppBarTheme(
          color: const Color(0xFF1E88E5),
          elevation: 0,
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(const Color(0xFF1E88E5)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
          titleLarge: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF2D2D2D),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color(0xFF1E88E5),
          foregroundColor: Colors.white,
        ),
      );
}
