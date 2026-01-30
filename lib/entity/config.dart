const _binaryPathKey = 'binaryPath';
const _configPathKey = 'configPath';

class Config {
  final String? binaryPath;
  final String? configPath;

  const Config({required this.binaryPath, required this.configPath});

  bool get isInitial => _isInitial();

  const Config.initial() : binaryPath = null, configPath = null;

  Config copyWith({String? binaryPath, String? configPath}) => Config(
    binaryPath: binaryPath ?? this.binaryPath,
    configPath: configPath ?? this.configPath,
  );

  Map<String, dynamic> toMap() {
    return {_binaryPathKey: binaryPath, _configPathKey: configPath};
  }

  factory Config.fromMap(Map<String, dynamic> map) =>
      Config(binaryPath: map[_binaryPathKey], configPath: map[_configPathKey]);

  bool _isInitial() => binaryPath == null && configPath == null;
}
