import 'package:nebula_ui/entity/enum/enum.dart';

const _binaryPathKey = 'binaryPath';
const _configPathKey = 'configPath';
const _themeKey = 'theme';

class Config {
  final String? binaryPath;
  final String? configPath;
  final Theme theme;

  const Config({
    required this.binaryPath,
    required this.configPath,
    required this.theme,
  });

  bool get isInitial => _isInitial();

  bool get isValid => binaryPath != null && configPath != null;

  const Config.initial() : binaryPath = null, configPath = null, theme = .light;

  Config copyWith({String? binaryPath, String? configPath, Theme? theme}) =>
      Config(
        binaryPath: binaryPath ?? this.binaryPath,
        configPath: configPath ?? this.configPath,
        theme: theme ?? this.theme,
      );

  Map<String, dynamic> toMap() {
    return {
      _binaryPathKey: binaryPath,
      _configPathKey: configPath,
      _themeKey: theme.themeName,
    };
  }

  factory Config.fromMap(Map<String, dynamic> map) => Config(
    binaryPath: map[_binaryPathKey],
    configPath: map[_configPathKey],
    theme: Theme.fromString(map[_themeKey]),
  );

  bool _isInitial() => binaryPath == null && configPath == null;

  @override
  bool operator ==(Object other) {
    if (other is! Config) {
      return false;
    }
    return binaryPath == other.binaryPath &&
        configPath == other.configPath &&
        theme == other.theme;
  }

  @override
  int get hashCode =>
      binaryPath.hashCode ^ configPath.hashCode ^ theme.hashCode;
}
