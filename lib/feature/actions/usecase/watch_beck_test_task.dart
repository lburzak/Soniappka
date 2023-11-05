import 'package:easy_beck/domain/beck_test/repository/beck_test_result_repository.dart';
import 'package:easy_beck/feature/actions/data/beck_test_action.dart';
import 'package:easy_beck/feature/actions/model/task.dart';
import 'package:easy_beck/feature/actions/usecase/calendar.dart';
import 'package:quiver/time.dart';

class WatchBeckTestTask {
  final BeckTestResultRepository _beckTestResultRepository;
  final Calendar _calendar;
  final Clock _clock;

  Stream<Task> call() => _beckTestResultRepository
      .watchSubmissionDateTimeOfLast()
      .map((lastSubmission) => Task(
          action: beckTestAction,
          lastCompleted: lastSubmission,
          status: switch (lastSubmission) {
            null => TaskStatus.pending,
            _ => _calendar.areSameDay(lastSubmission, _clock.now()) ? TaskStatus.completed : TaskStatus.pending,

          }));

  const WatchBeckTestTask({
    required BeckTestResultRepository beckTestResultRepository,
    required Calendar calendar,
    required Clock clock,
  })  : _beckTestResultRepository = beckTestResultRepository,
        _calendar = calendar,
        _clock = clock;
}
