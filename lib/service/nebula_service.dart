import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nebula_ui/entity/entity.dart';

const _configArg = '-config';

class NebulaService {
  final ValueNotifier<Process?> _nebulaProcess = ValueNotifier(null);
  final _out = StreamController<String>.broadcast();
  final _err = StreamController<String>.broadcast();

  Stream<String> get stdout => _out.stream;
  Stream<String> get stderr => _err.stream;

  bool get isRunning => _nebulaProcess.value != null;

  Future<void> start(Config config) async {
    if (_nebulaProcess.value != null) {
      stopNebula();
    }

    final process = Platform.isLinux
        ? await Process.start('pkexec', [
            config.binaryPath!,
            _configArg,
            config.configPath!,
          ])
        : await Process.start(config.binaryPath!, [
            _configArg,
            config.configPath!,
          ],);

    _nebulaProcess.value = process;

    process.stdout.transform(utf8.decoder).transform(const LineSplitter()).listen(_out.add);
    process.stderr.transform(utf8.decoder).transform(const LineSplitter()).listen(_err.add);

    process.exitCode.then((code) {
      _out.add('Nebula exited with code $code');
      _nebulaProcess.value = null;
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

  Future<void> stopNebula() async {
    final process = _nebulaProcess.value;
    
    if (process == null) return;

    process.kill();
    await process.exitCode;
    _nebulaProcess.value = null;
  }
}
