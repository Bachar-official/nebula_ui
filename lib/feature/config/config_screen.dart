import 'package:flutter/material.dart';
import 'package:nebula_ui/app/scope.dart';
import 'package:nebula_ui/feature/config/config_state.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopeBuilder<AppScopeContainer>.withPlaceholder(
      builder: (ctx, scope) {
        final manager = scope.configManager.get;

        return StateBuilder<ConfigState>(
          stateReadable: manager,
          builder: (context, state, _) => Scaffold(
            appBar: AppBar(
              title: const Text('Settings'),
            ),
            body: Center(
              child: Column(),
            ),
          ),
        );
      },
    );
  }
}
