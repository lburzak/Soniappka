import 'package:easy_beck/domain/actions/model/task.dart';
import 'package:easy_beck/domain/actions/repository/action_completion_repository.dart';
import 'package:quiver/time.dart';

class ToggleTask {
  final ActionCompletionRepository _actionCompletionRepository;
  final Clock _clock;

  void call(Task task) {
    if (task.status == TaskStatus.completed) {
      _actionCompletionRepository.removeLastCompletion(task.action.id);
    } else {
      _actionCompletionRepository.addCompletion(task.action.id, _clock.now());
    }
  }

  const ToggleTask({
    required ActionCompletionRepository actionCompletionRepository,
    required Clock clock,
  })  : _actionCompletionRepository = actionCompletionRepository,
        _clock = clock;
}
