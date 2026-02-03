import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:nebula_ui/app/routing.dart';
import 'package:nebula_ui/components/empty_config_dialog.dart';
import 'package:nebula_ui/entity/entity.dart';
import 'package:nebula_ui/entity/enum/enum.dart';
import 'package:nebula_ui/feature/config/config_state.dart';
import 'package:nebula_ui/service/service.dart';

class ConfigManager extends ManagerBase<ConfigState>
    with CEHandler, SnackbarMixin, LoggerMixin {
  final ConfigService configService;
  final NebulaService nebulaService;

  ConfigManager(
    super.state, {
    required super.deps,
    required this.configService,
    required this.nebulaService,
  }) {
    getAllNebulaConfig();
  }

  void setIsLoading(bool isLoading) =>
      handle((emit) async => emit(state.copyWith(isLoading: isLoading)));

  void setConfigBinary(String path) => handle((emit) async {
    final newConfig = state.config.copyWith(binaryPath: path);
    emit(state.copyWith(config: newConfig));
  });

  void setConfigYml(String path) => handle((emit) async {
    emit(state.copyWith(config: state.config.copyWith(configPath: path)));
  });

  void setTheme(Theme? theme) => handle((emit) async {
    emit(state.copyWith(config: state.config.copyWith(theme: theme)));
  });

  Future<void> getAllNebulaConfig() async {
    debug('Trying to get Nebula config');
    try {
      setIsLoading(true);
      final config = await configService.getConfig();
      if (config.isInitial) {
        warning('Nebula config not found');        
        final settingsResult = await showDialog<bool>(context: deps.navKey.currentState!.context, builder: (ctx) => EmptyConfigDialog());
        if (settingsResult!) {
          deps.navKey.currentState!.pushNamed(AppRouter.preferences);
        }            
      }
      handle((emit) async => emit(state.copyWith(config: config)));
    } catch (e, s) {
      catchException(
        deps: deps,
        exception: e,
        stacktrace: s,
        message: 'Error while getting Nebula config',
      );
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> setNebulaBinary() async {
    debug('Trying to set Nebula binary');
    try {
      setIsLoading(true);
      final result = await FilePicker.platform.pickFiles(
        dialogTitle: 'Select Nebula binary',
      );
      checkCondition(
        result == null || result.files.isEmpty,
        'Binary not selected',
      );
      setConfigBinary(result!.files.first.path!);
      success('Nebula binary set');
    } catch (e, s) {
      catchException(
        deps: deps,
        exception: e,
        stacktrace: s,
        message: 'Error while setting Nebula binary',
      );
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> setNebulaConfig() async {
    debug('Trying to set Nebula config');
    try {
      setIsLoading(true);
      final result = await FilePicker.platform.pickFiles(
        dialogTitle: 'Select Nebula config',
        type: .custom,
        allowedExtensions: ['yml', 'yaml'],
      );
      checkCondition(
        result == null || result.files.isEmpty,
        'Config not selected',
      );
      setConfigYml(result!.files.first.path!);
      success('Nebula config set');
    } catch (e, s) {
      catchException(
        deps: deps,
        exception: e,
        stacktrace: s,
        message: 'Error while setting Nebula config',
      );
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> saveAllConfig() async {
    debug('Trying to save Nebula config');
    try {
      setIsLoading(true);
      await configService.setConfig(state.config);
      success('Nebula config saved');
      showSnackbar(
        deps: deps,
        reason: .success,
        message: 'Nebula config saved',
      );
    } catch (e, s) {
      catchException(
        deps: deps,
        exception: e,
        stacktrace: s,
        message: 'Error while saving Nebula config',
      );
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> testConfig() async {
    debug('Trying to test Nebula config');
    try {
      setIsLoading(true);
      await nebulaService.testNebulaConfig(state.config);
      success('Nebula config tested');
      showSnackbar(
        deps: deps,
        reason: .success,
        message: 'Nebula config working!',
      );
    } catch (e, s) {
      catchException(
        deps: deps,
        exception: e,
        stacktrace: s,
        message: 'Error while testing Nebula config',
      );
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> searchNebulaBinary() async {
    debug('Trying to search Nebula binary');
    try {
      setIsLoading(true);
      final result = await configService.getNebulaPath();
      checkCondition(result.isEmpty, 'Nebula binary not found. Please, set it manually.');
      setConfigBinary(result);
    } catch (e, s) {
      catchException(
        deps: deps,
        exception: e,
        stacktrace: s,
        message: 'Error while searching Nebula binary',
      );
    } finally {
      setIsLoading(false);
    }
  }
}
