import 'package:easy_beck/di/common.dart';
import 'package:easy_beck/di/hive.dart';
import 'package:easy_beck/di/in_memory.dart';
import 'package:easy_beck/di/json.dart';
import 'package:easy_beck/domain/actions/use_case/toggle_task.dart';
import 'package:easy_beck/domain/actions/use_case/watch_beck_test_task.dart';
import 'package:easy_beck/domain/beck_test/usecase/check_beck_test_solved.dart';
import 'package:easy_beck/domain/beck_test/usecase/get_beck_test_result.dart';
import 'package:easy_beck/domain/beck_test/usecase/submit_beck_test.dart';
import 'package:easy_beck/domain/symptoms/use_case/set_symptom_level.dart';
import 'package:easy_beck/domain/symptoms/use_case/watch_symptom_level.dart';

late final DomainDependencyGraph domainDependencyGraph =
    DomainDependencyGraph._();

class DomainDependencyGraph {
  late final toggleTask = ToggleTask(
      actionCompletionRepository:
          inMemoryDependencyGraph.actionCompletionRepository,
      clock: commonDependencyGraph.clock);
  late final watchBeckTestTask = WatchBeckTestTask(
    beckTestResultRepository: hiveDependencyGraph.beckTestResultRepository,
    clock: commonDependencyGraph.clock,
    calendar: commonDependencyGraph.calendar,
  );
  late final checkBeckTestStatusForDay = CheckBeckTestStatusForDay(
      beckTestResultRepository: hiveDependencyGraph.beckTestResultRepository);
  late final submitBeckTest = SubmitBeckTest(
      jsonDependencyContext.jsonFileBeckRepository,
      hiveDependencyGraph.beckTestResultRepository,
      commonDependencyGraph.clock);
  late final getBeckTestResult =
      GetBeckTestResult(hiveDependencyGraph.beckTestResultRepository);

  late final watchSleepinessSymptomLevel = WatchSymptomLevel(
      hiveDependencyGraph.sleepinessRepository);
  late final watchIrritabilitySymptomLevel = WatchSymptomLevel(
      hiveDependencyGraph.irritabilityRepository);
  late final watchAnxietySymptomLevel =
      WatchSymptomLevel(hiveDependencyGraph.anxietyRepository);
  late final setSleepinessSymptomLevel = SetSymptomLevel(
      hiveDependencyGraph.sleepinessRepository);
  late final setIrritabilitySymptomLevel = SetSymptomLevel(
      hiveDependencyGraph.irritabilityRepository);
  late final setAnxietySymptomLevel =
      SetSymptomLevel(hiveDependencyGraph.anxietyRepository);


  DomainDependencyGraph._();
}
