import 'package:flutter/material.dart';
import 'package:nebula_ui/feature/config/config_screen.dart';
import 'package:nebula_ui/feature/home/home_screen.dart';

class AppRouter {
  static const home = '/';
  static const preferences = '/settings';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home: return _buildRoute((ctx) => const HomeScreen(), settings);
      case preferences: return _buildRoute((ctx) => const ConfigScreen(), settings);
      default: throw Exception('Invalid route: ${settings.name}');
    }
  }
}

MaterialPageRoute _buildRoute(WidgetBuilder builder, RouteSettings settings) => MaterialPageRoute(builder: builder, settings: settings);