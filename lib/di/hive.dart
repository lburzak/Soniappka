import 'package:easy_beck/hive/adapter/symptom_log_adapter.dart';
import 'package:easy_beck/hive/beck_test_result/beck_test_result_adapter.dart';
import 'package:easy_beck/hive/beck_test_result/hive_beck_test_result_repository.dart';
import 'package:easy_beck/hive/hive_loader.dart';
import 'package:easy_beck/hive/hive_symptom_repository.dart';

late final HiveDependencyGraph hiveDependencyGraph = HiveDependencyGraph._();

class HiveDependencyGraph {
  late final symptomLogAdapter = SymptomLogAdapter();
  late final beckTestResultAdapter = BeckTestResultAdapter();
  late final hiveLoader = HiveLoader(
      symptomLogAdapter: symptomLogAdapter,
      beckTestResultAdapter: beckTestResultAdapter);
  late final sleepRepository = HiveSymptomRepository(hiveLoader.sleepBox);
  late final anxietyRepository = HiveSymptomRepository(hiveLoader.anxietyBox);
  late final sleepinessRepository =
  HiveSymptomRepository(hiveLoader.sleepinessBox);
  late final irritabilityRepository = HiveSymptomRepository(
      hiveLoader.sleepBox);
  late final beckTestResultRepository = HiveBeckTestResultRepository(
      hiveLoader.beckTestResultBox);

  HiveDependencyGraph._();
}
