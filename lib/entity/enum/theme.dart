import 'package:flutter/material.dart';

enum Theme {
  light('light'),
  dark('dark');

  final String themeName;
  const Theme(this.themeName);

  ThemeData get theme {
    return switch (this) {
      Theme.light => _lightTheme,
      Theme.dark => _darkTheme,
    };
  }

  factory Theme.fromString(String themeName) => Theme.values.firstWhere((element) => element.themeName.toLowerCase() == themeName.toLowerCase());

  @override
  String toString() => themeName;
}

ThemeData _lightTheme = ThemeData.light().copyWith(colorScheme: .fromSeed(seedColor: Colors.red));
ThemeData _darkTheme = ThemeData.dark().copyWith(colorScheme: .fromSeed(seedColor: Colors.red));


