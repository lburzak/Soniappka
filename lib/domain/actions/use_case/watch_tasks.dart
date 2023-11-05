import 'package:easy_beck/domain/actions/model/action.dart';
import 'package:easy_beck/domain/actions/model/task.dart';
import 'package:easy_beck/domain/actions/repository/action_completion_repository.dart';
import 'package:easy_beck/domain/actions/repository/action_repository.dart';
import 'package:easy_beck/domain/actions/use_case/get_task_status.dart';
import 'package:rxdart/rxdart.dart';

class WatchTasks {
  final ActionRepository _actionRepository;
  final GetTaskStatus _getTaskStatus;
  final ActionCompletionRepository _actionCompletionRepository;

  Stream<Iterable<Task>> call() {
    return _actionRepository
        .watchActiveActions()
        .flatMap((value) => Rx.combineLatestList(value.map(_actionToTask)));
  }

  Stream<Task> _actionToTask(Action action) => _actionCompletionRepository
          .watchDateTimeOfLastCompletion(action.id)
          .map((lastCompletionDateTime) {
        if (lastCompletionDateTime == null) {
          return Task(
              action: action, lastCompleted: null, status: TaskStatus.pending);
        }

        return Task(
            action: action,
            lastCompleted: lastCompletionDateTime,
            status: _getTaskStatus(action, lastCompletionDateTime));
      });

  const WatchTasks({
    required ActionRepository actionRepository,
    required GetTaskStatus getTaskStatus,
    required ActionCompletionRepository actionCompletionRepository,
  })  : _actionRepository = actionRepository,
        _getTaskStatus = getTaskStatus,
        _actionCompletionRepository = actionCompletionRepository;
}
