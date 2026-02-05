import 'dart:io';
import 'dart:convert';

import 'package:nebula_ui/entity/entity.dart';
import 'package:nebula_ui/utils/utils.dart';

const configPath = 'config.json';

class ConfigService {
  Future<String> getNebulaPath() async {
    if (Platform.isLinux || Platform.isWindows) {
      final cmd = await Process.run(Platform.isLinux ? 'which' : 'where', ['nebula']);
      return decodeCLIMessage(cmd).trim();
    }

    throw Exception('Platform not supported');
  }

  Future<Config> getConfig() async {
    final configFile = File(configPath);
    if (!await configFile.exists()) {
      return Config.initial();
    }
    final map = jsonDecode(await configFile.readAsString());
    return Config.fromMap(map);
  }

  Future<void> setConfig(Config config) async {
    final configFile = File(configPath);
    await configFile.writeAsString(jsonEncode(config.toMap()));
  }

  Future<bool> isConfigDirty(Config localConfig) async {
    final savedConfig = await getConfig();
    return localConfig != savedConfig;
  }
}
