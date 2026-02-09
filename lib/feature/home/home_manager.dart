import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nebula_ui/app/routing.dart';
import 'package:nebula_ui/entity/entity.dart';
import 'package:nebula_ui/feature/home/home_state.dart';
import 'package:nebula_ui/service/service.dart';

class HomeManager extends ManagerBase<HomeState>
    with CEHandler, SnackbarMixin, LoggerMixin {
  final ConfigService configService;
  final NebulaService nebulaService;

  HomeManager(
    super.state, {
    required super.deps,
    required this.configService,
    required this.nebulaService,
  });

  final logsC = TextEditingController();
  Stream<String>? _stdStream;
  Stream<String>? _errStream;
  final StreamController<String> _logStreamController = StreamController();

  bool get isConnected => nebulaService.isRunning;

  void setIsLoading(bool isLoading) =>
      handle((emit) async => emit(state.copyWith(isLoading: isLoading)));

  void setLogLevels(Set<LogLevel> logLevels) =>
      handle((emit) async => emit(state.copyWith(logLevels: logLevels)));

  Future<void> goToSettingsScreen() async =>
      await deps.navKey.currentState!.pushNamed(AppRouter.preferences);

  Future<void> startNebula() async {
    debug('Try to start Nebula');
    try {
      final config = configService.config;
      checkCondition(config.isInitial, 'Config is empty');
      nebulaService.start(config);
      _stdStream = nebulaService.stdout;
      _errStream = nebulaService.stderr;

      _stdStream?.listen((line) {
        debug(line);
        logsC.text += '$line\n';
      });
  
    } catch(e, s) {
      catchException(deps: deps, exception: e, stacktrace: s, message: 'Error while starting Nebula');
    }
  }

  Future<void> stopNebula() async {
    debug('Try to stop Nebula');
    try {
      await nebulaService.stopNebula();
      _stdStream = null;
      _errStream = null;
    } catch (e, s) {
      catchException(deps: deps, exception: e, stacktrace: s, message: 'Error while stopping Nebula');
    }
  }
}
