import 'dart:async';
import 'dart:io';

import 'package:nebula_ui/entity/entity.dart';

const _configArg = '-config';

class NebulaService {
  Process? _nebulaProcess;
  Stream? nebulaStdOut;
  Stream? nebulaStdErr;

  Future<void> startNebula(Config config) async {
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

    nebulaStdOut = _nebulaProcess!.stdout;
    nebulaStdErr = _nebulaProcess!.stderr;
  }

  Future<void> testNebulaConfig(Config config) async {
    final result = await Process.run(
      config.binaryPath!.trim(),
      [        
        '-test',
        _configArg,
        config.configPath!.trim(),
      ],
    );

    if (result.exitCode != 0) {
      throw Exception(
        result.stderr.toString().trim(),
      );
    }
  }

  void stopNebula() {
    _nebulaProcess?.kill();
    nebulaStdErr = null;
    nebulaStdOut = null;
  }
}
