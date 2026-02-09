import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:nebula_ui/entity/entity.dart';
import 'package:nebula_ui/utils/utils.dart';

const configPath = 'config.json';

class ConfigService {
  final _config = ValueNotifier(Config.initial());

  Config get config => _config.value;

  Future<String> getNebulaPath() async {
    if (Platform.isLinux || Platform.isWindows) {
      final cmd = await Process.run(Platform.isLinux ? 'which' : 'where', ['nebula']);
      return decodeCLIMessage(cmd).trim();
    }

    throw Exception('Platform not supported');
  }

  Future<void> setConfig(Config config) async {
    final configFile = File(configPath);
    await configFile.writeAsString(jsonEncode(config.toMap()));
    _config.value = config;
  }

  Future<void> getConfig() async {
    final configFile = File(configPath);
    if (await configFile.exists()) {
      final configJson = await configFile.readAsString();
      _config.value = Config.fromMap(jsonDecode(configJson));
    } else {
      _config.value = Config.initial();
    }    
  }

  Future<bool> isConfigDirty(Config localConfig) async {
    return _config.value != localConfig;
  }
}
