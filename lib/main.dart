import 'package:flutter/widgets.dart';
import 'package:nebula_ui/app/app.dart';
import 'package:nebula_ui/app/scope.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appScopeHolder = AppScopeHolder();
  await appScopeHolder.create();
  runApp(ScopeProvider(holder: appScopeHolder, child: const App()));
}