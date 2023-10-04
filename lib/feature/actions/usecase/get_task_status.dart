import 'package:easy_beck/feature/actions/model/action.dart';
import 'package:easy_beck/feature/actions/model/task.dart';
import 'package:easy_beck/feature/actions/repository/action_completion_repository.dart';
import 'package:easy_beck/feature/actions/usecase/calendar.dart';
import 'package:easy_beck/feature/actions/usecase/day_phase_clock.dart';
import 'package:quiver/time.dart';

class GetTaskStatus {
  final Clock _clock;
  final Calendar _calendar;
  final DayPhaseClock _dayPhaseClock;

  TaskStatus call(Action action, DateTime lastCompletionDateTime) {
    return switch (action.regularity) {
      Daily(dayPhase: final dayPhase) =>
        _forDaily(dayPhase, lastCompletionDateTime),
      Weekly(dayOfWeek: final dayOfWeek) =>
        _forWeekly(dayOfWeek, lastCompletionDateTime),
      Irregular() => _forIrregular(lastCompletionDateTime)
    };
  }

  TaskStatus _forDaily(DayPhase? dayPhase, DateTime lastCompletionDateTime) {
    if (_calendar.areSameDay(_clock.now(), lastCompletionDateTime)) {
      return TaskStatus.completed;
    }

    if (dayPhase == null) {
      return TaskStatus.pending;
    }

    return dayPhase.isBefore(_dayPhaseClock.current())
        ? TaskStatus.failed
        : TaskStatus.pending;
  }

  TaskStatus _forWeekly(DayOfWeek? dayOfWeek, DateTime lastCompletionDateTime) {
    if (_calendar.areSameWeek(_clock.now(), lastCompletionDateTime)) {
      return TaskStatus.completed;
    }

    if (dayOfWeek == null) {
      return TaskStatus.pending;
    }

    return dayOfWeek.isBefore(_calendar.currentDayOfWeek())
        ? TaskStatus.failed
        : TaskStatus.pending;
  }

  TaskStatus _forIrregular(DateTime lastCompletionDateTime) {
    if (_calendar.areSameDay(_clock.now(), lastCompletionDateTime)) {
      return TaskStatus.completed;
    }

    return TaskStatus.pending;
  }

  const GetTaskStatus({
    required ActionCompletionRepository actionCompletionRepository,
    required Clock clock,
    required Calendar calendar,
    required DayPhaseClock dayPhaseClock,
  })  : _clock = clock,
        _calendar = calendar,
        _dayPhaseClock = dayPhaseClock;
}
