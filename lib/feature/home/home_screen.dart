import 'package:flutter/material.dart';
import 'package:nebula_ui/app/scope.dart';
import 'package:nebula_ui/entity/entity.dart';
import 'package:nebula_ui/feature/home/home_state.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopeBuilder<AppScopeContainer>.withPlaceholder(
      placeholder: const Placeholder(),
      builder: (ctx, scope) {
        final manager = scope.homeManager.get;

        return StateBuilder<HomeState>(
          stateReadable: manager,
          builder: (context, state, _) => Scaffold(
            appBar: AppBar(
              title: const Text('Nebula UI'),
              leading: Tooltip(
                message: manager.isConnected ? 'Connected' : 'Disconnected',
                child: Icon(
                  manager.isConnected ? Icons.cloud : Icons.cloud_off,
                  color: manager.isConnected ? Colors.green : Colors.red,
                ),
              ),
              actions: [
                IconButton(
                  tooltip: 'Go to Settings page',
                  icon: const Icon(Icons.settings),
                  onPressed: manager.goToSettingsScreen,
                ),
              ],
            ),
            body: Center(
              child: state.isLoading
                  ? CircularProgressIndicator()
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: .min,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 80,
                            child: ElevatedButton(
                              onPressed: manager.isConnected ? manager.stopNebula : manager.startNebula,
                              child: FittedBox(
                                child: Text(
                                  textScaler: .linear(1.5),
                                  manager.isConnected ? 'Disconnect' : 'Connect',
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: .all(8.0),
                              child: Row(
                                mainAxisAlignment: .spaceEvenly,
                                children: [
                                  const Text('Log level'),
                                  SegmentedButton<LogLevel>(
                                    multiSelectionEnabled: true,
                                    segments: LogLevel.values
                                        .map(
                                          (level) => ButtonSegment(
                                            value: level,
                                            label: Text(level.name),
                                          ),
                                        )
                                        .toList(),
                                    selected: state.logLevels,
                                    onSelectionChanged: manager.setLogLevels,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: manager.logsC,
                              maxLines: 1000,
                              readOnly: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                helperText: 'Logs',
                              ),
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
