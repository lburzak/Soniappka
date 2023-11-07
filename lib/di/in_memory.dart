import 'package:easy_beck/in_memory/in_memory_action_completion_repository.dart';

late final InMemoryDependencyGraph inMemoryDependencyGraph =
    InMemoryDependencyGraph._();

class InMemoryDependencyGraph {
  late final actionCompletionRepository = InMemoryActionCompletionRepository();

  InMemoryDependencyGraph._();
}
