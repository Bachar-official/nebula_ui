import 'package:nebula_ui/entity/entity.dart';

class ConfigState {
  final bool isLoading;
  final Config config;

  const ConfigState({required this.isLoading, required this.config});

  ConfigState.initial(): isLoading = false, config = Config.initial();

  ConfigState copyWith({bool? isLoading, Config? config}) => ConfigState(
    isLoading: isLoading ?? this.isLoading,
    config: config ?? this.config,
  );
}