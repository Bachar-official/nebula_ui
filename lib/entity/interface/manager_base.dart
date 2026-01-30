import 'package:nebula_ui/entity/interface/has_deps.dart';
import 'package:nebula_ui/entity/manager_deps.dart';
import 'package:yx_state/yx_state.dart';

abstract class ManagerBase<S> extends StateManager<S> implements HasDeps {
  @override
  final ManagerDeps deps;

  ManagerBase(super.state, {required this.deps});
}
