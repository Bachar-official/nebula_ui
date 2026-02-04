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
            appBar: AppBar(
              title: const Text('Settings'),
              actions: [
                IconButton(
                  tooltip: 'Save config',
                  icon: const Icon(Icons.save),
                  onPressed: state.config.isValid ? manager.saveAllConfig : null,
                ),
              ],
            ),
            body: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: .min,
                        crossAxisAlignment: .center,
                        spacing: 10.0,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: .center,
                            children: [
                              Expanded(
                                flex: 5,
                                child: TextField(
                                  controller: manager.binaryPathC,
                                  decoration: InputDecoration(
                                    labelText: 'Nebula binary path',
                                    border: OutlineInputBorder(),
                                  ),
                                  readOnly: true,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                  onPressed: manager.setNebulaBinary,
                                  child: const Text('Browse...'),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                  onPressed: manager.searchNebulaBinary,
                                  child: const Text('Find'),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: .center,
                            children: [
                              Expanded(
                                flex: 5,
                                child: TextField(
                                  controller: manager.configPathC,
                                  decoration: InputDecoration(
                                    labelText: 'Nebula config path',
                                    border: OutlineInputBorder(),
                                  ),
                                  readOnly: true,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                  onPressed: manager.setNebulaConfig,
                                  child: const Text('Browse...'),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                  onPressed:
                                      state.config.configPath == null ||
                                          state.config.binaryPath == null
                                      ? null
                                      : manager.testConfig,
                                  child: const Text('Test'),
                                ),
                              ),
                            ],
                          ),
                          DropdownButtonFormField<Theme>(
                            initialValue: state.config.theme,
                            items: Theme.values
                                .map(
                                  (el) => DropdownMenuItem(
                                    value: el,
                                    child: Text(el.themeName),
                                  ),
                                )
                                .toList(),
                            onChanged: manager.setTheme,
                            decoration: InputDecoration(
                              labelText: 'App theme',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
