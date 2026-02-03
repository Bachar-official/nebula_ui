import 'package:flutter/material.dart' hide Theme;
import 'package:nebula_ui/app/scope.dart';
import 'package:nebula_ui/entity/enum/enum.dart';
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
            appBar: AppBar(title: const Text('Settings')),
            body: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: Column(
                      mainAxisSize: .min,
                      crossAxisAlignment: .center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: .center,
                          children: [
                            Text('Nebula binary: ${state.config.binaryPath ?? 'Not set'}'),
                            TextButton(
                              onPressed: manager.setNebulaBinary,
                              child: const Text('Set'),
                            ),
                            TextButton(
                              onPressed: manager.searchNebulaBinary,
                              child: const Text('Find'),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: .center,
                          children: [
                            Text('Nebula config: ${state.config.configPath ?? 'Not set'}'),
                            TextButton(
                              onPressed: manager.setNebulaConfig,
                              child: const Text('Set'),
                            ),
                            TextButton(
                              onPressed: state.config.configPath == null || state.config.binaryPath == null ? null : manager.testConfig,
                              child: const Text('Test'),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: .center,
                          children: [
                            Text('Current theme:'),
                            DropdownButton<Theme>(
                              value: state.config.theme,
                              items: Theme.values.map((el) => DropdownMenuItem(value: el, child: Text(el.themeName))).toList(),
                              onChanged: manager.setTheme)
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
