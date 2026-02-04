import 'package:flutter/material.dart';
import 'package:nebula_ui/app/routing.dart';
import 'package:nebula_ui/app/scope.dart';
import 'package:nebula_ui/components/splash_screen.dart';
import 'package:nebula_ui/feature/config/config_state.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => ScopeBuilder<AppScopeContainer>.withPlaceholder(
    placeholder: const SplashScreen(),
    builder: (ctx, scope) {
      return StateBuilder<ConfigState>(
        stateReadable: scope.configManager.get,
        builder: (context, state, _) => MaterialApp(
          onGenerateRoute: AppRouter.onGenerateRoute,
          scaffoldMessengerKey: scope.deps.get.scaffoldKey,
          navigatorKey: scope.deps.get.navKey,
          theme: state.config.theme.themeData,
        ),
      );
    },
  );
}
