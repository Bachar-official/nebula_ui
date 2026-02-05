import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:nebula_ui/entity/entity.dart';

const _configArg = '-config';

class NebulaService {
  Process? _nebulaProcess;
  final StreamController<String> _stdOutController =
      StreamController<String>.broadcast();
  final StreamController<String> _stdErrController =
      StreamController<String>.broadcast();

  Stream<String> get nebulaStdOut => _stdOutController.stream;
  Stream<String> get nebulaStdErr => _stdErrController.stream;

  final StreamController<bool> _isRunningController =
      StreamController<bool>.broadcast();
  Stream<bool> get isRunning => _isRunningController.stream;

  final List<StreamSubscription> _subscriptions = [];

  Future<void> startNebula(Config config) async {
    if (_nebulaProcess != null) {
      stopNebula();
    }

    _nebulaProcess = Platform.isLinux
        ? await Process.start('pkexec', [
            config.binaryPath!,
            _configArg,
            config.configPath!,
          ], runInShell: false)
        : await Process.start(config.binaryPath!, [
            _configArg,
            config.configPath!,
          ], mode: ProcessStartMode.detached);

    _subscriptions.addAll([
      _nebulaProcess!.stdout
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .listen((line) {
            _stdOutController.add(line);
          }),
      _nebulaProcess!.stderr
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .listen((line) {
            _stdErrController.add(line);
          }),
    ]);

    _nebulaProcess!.exitCode.then((code) {
      _stdOutController.add('Nebula process exited with code: $code');
      _cleanup();
      _isRunningController.add(false);
    });
  }

  Future<void> testNebulaConfig(Config config) async {
    final result = await Process.run(config.binaryPath!.trim(), [
      '-test',
      _configArg,
      config.configPath!.trim(),
    ]);

    if (result.exitCode != 0) {
      throw Exception(result.stderr.toString().trim());
    }
  }

  void _cleanup() {
    for (var sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();

    _nebulaProcess = null;
    _isRunningController.add(false);
  }

  void stopNebula() async {
    if (_nebulaProcess != null) {
      _stdOutController.add('Stopping Nebula...');
      _nebulaProcess!.kill();
      await _nebulaProcess!.exitCode;
      _cleanup();
      _stdOutController.add('Nebula stopped');
    }
  }

  void dispose() {
    stopNebula();
    _stdOutController.close();
    _stdErrController.close();
    _isRunningController.close();
  }
}
