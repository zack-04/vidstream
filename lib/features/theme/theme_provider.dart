import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/shared_preferences.dart';

// Define your light and dark themes
final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  iconTheme: const IconThemeData(color: Colors.black),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
  ),
  colorScheme: const ColorScheme.light(background: Colors.white),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    bodySmall: TextStyle(color: Colors.blueGrey),
    // Define other text styles if needed
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.black, // Dark theme button color
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: TextStyle(fontSize: 10), // Adjust font size
    unselectedLabelStyle: TextStyle(fontSize: 10),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.black,
    unselectedLabelColor: Color.fromRGBO(94, 93, 93, 1),
  ),
  // Add other light theme properties here
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
  iconTheme: const IconThemeData(color: Colors.white),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
  ),
  colorScheme: const ColorScheme.dark(background: Colors.black),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    // Define other text styles if needed
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.white, // Dark theme button color
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white.withOpacity(0.4),
    selectedLabelStyle: const TextStyle(fontSize: 10), // Adjust font size
    unselectedLabelStyle: const TextStyle(fontSize: 10),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.white,
    unselectedLabelColor: Colors.grey,
  ),
  // Add other dark theme properties here
);

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (ref) => ThemeNotifier(),
);

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final ThemePreference _preference = ThemePreference();

  ThemeNotifier() : super(ThemeMode.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    state = await _preference.getThemeMode();
  }

  void toggleTheme(bool isDark) {
    final newTheme = isDark ? ThemeMode.dark : ThemeMode.light;
    state = newTheme;
    _preference.saveThemeMode(newTheme);
  }
}
