import 'package:flutter/material.dart';
import 'package:nebula_ui/feature/config/config_manager.dart';
import 'package:nebula_ui/feature/config/config_state.dart';
import 'package:nebula_ui/service/service.dart';
import 'package:yx_scope/yx_scope.dart';
import 'package:logger/logger.dart';

class AppScopeContainer extends ScopeContainer {
  late final deps = dep(
    () => (
      logger: Logger(),
      scaffoldKey: GlobalKey<ScaffoldMessengerState>(),
      navKey: GlobalKey<NavigatorState>(),
    ),
  );

  late final configService = dep(() => ConfigService());
  late final nebulaService = dep(() => NebulaService());

  late final configManager = dep(
    () => (ConfigManager(
      ConfigState.initial(),
      deps: deps.get,
      configService: configService.get,
      nebulaService: nebulaService.get,
    )),
  );
}

class AppScopeHolder extends ScopeHolder<AppScopeContainer> {
  @override
  AppScopeContainer createContainer() => AppScopeContainer();
}
