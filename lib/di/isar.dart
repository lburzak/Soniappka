import 'package:easy_beck/isar/actions/isar_action_repository.dart';
import 'package:easy_beck/isar/isar_loader.dart';

late final IsarDependencyGraph isarDependencyGraph = IsarDependencyGraph._();

class IsarDependencyGraph {
  late final isarLoader = IsarLoader();
  late final actionCompletionRepository = IsarActionRepository(
      isarLoader.actionsCollection);

  IsarDependencyGraph._();
}
