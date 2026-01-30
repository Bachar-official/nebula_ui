import 'package:nebula_ui/entity/enum/snackbar_reason.dart';
import 'package:nebula_ui/entity/interface/has_deps.dart';
import 'package:nebula_ui/entity/manager_deps.dart';
import 'package:nebula_ui/exception/condition_exception.dart';

mixin SnackbarMixin on HasDeps {

  void showSnackbar({
    required ManagerDeps deps,
    required SnackbarReason reason,
    required String message,
  }) {
    if (deps.scaffoldKey.currentState != null &&
        deps.scaffoldKey.currentState!.mounted) {
      deps.scaffoldKey.currentState!.showSnackBar(reason.toSnackbar(message));
    }
  }

  void catchException({
    required ManagerDeps deps,
    required Object exception,
    StackTrace? stacktrace,
    required String message,
  }) {
    final msg = '$message:\n$exception';
    if (exception is ConditionException) {
      deps.logger.w(msg);
      showSnackbar(deps: deps, reason: SnackbarReason.warning, message: msg);
    } else {
      deps.logger.e(msg, stackTrace: stacktrace);
      showSnackbar(deps: deps, reason: SnackbarReason.error, message: msg);
    }
  }
}
