import 'package:nebula_ui/entity/entity.dart';

class HomeState {
  final bool isLoading;
  final Set<LogLevel> logLevels;

  const HomeState({required this.isLoading, required this.logLevels});

  HomeState.initial() : isLoading = false, logLevels = {.error};

  HomeState copyWith({bool? isLoading, Set<LogLevel>? logLevels}) => HomeState(
    isLoading: isLoading ?? this.isLoading,
    logLevels: logLevels ?? this.logLevels,
  );
}
