import 'package:easy_beck/domain/actions/model/task.dart';
import 'package:easy_beck/domain/actions/use_case/toggle_task.dart';
import 'package:easy_beck/domain/actions/use_case/watch_beck_test_task.dart';
import 'package:easy_beck/domain/beck_test/usecase/check_beck_test_solved.dart';
import 'package:easy_beck/domain/common/day.dart';
import 'package:easy_beck/feature/actions/service/tasks_list_router.dart';

class TasksListController {
  final WatchBeckTestTask _watchBeckTestTask;
  final CheckBeckTestStatusForDay _checkBeckTestSolvedForDay;
  final ToggleTask _toggleTask;
  final TasksListRouter _router;
  final Day _day;

  Stream<List<Task>> get tasks =>
      _watchBeckTestTask().map((beckTestTask) => [beckTestTask]);

  void toggleTask(Task task) {
    _toggleTask(task);
  }

  void openBeckTest() async {
    final solved = await _checkBeckTestSolvedForDay(_day);
    if (solved) {
      _router.showBeckTestAlreadySolvedWarning(onProceed: () {
        _router.goToBeckTest();
      });
    } else {
      _router.goToBeckTest();
    }
  }

  const TasksListController({
    required WatchBeckTestTask watchBeckTestTask,
    required CheckBeckTestStatusForDay checkBeckTestStatusForDay,
    required ToggleTask toggleTask,
    required TasksListRouter router,
    required Day day,
  })  : _watchBeckTestTask = watchBeckTestTask,
        _checkBeckTestSolvedForDay = checkBeckTestStatusForDay,
        _toggleTask = toggleTask,
        _router = router,
        _day = day;
}
