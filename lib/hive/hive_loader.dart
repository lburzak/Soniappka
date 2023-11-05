import 'package:easy_beck/domain/symptoms/model/symptom_log.dart';
import 'package:easy_beck/feature/beck_test/model/beck_test_result.dart';
import 'package:easy_beck/common/one_time_loader.dart';
import 'package:easy_beck/hive/adapter/beck_test_result_adapter.dart';
import 'package:easy_beck/hive/adapter/symptom_log_adapter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

class HiveLoader extends OneTimeLoader {
  final SymptomLogAdapter symptomLogAdapter;
  final BeckTestResultAdapter beckTestResultAdapter;

  late Box<SymptomLog> irritabilityBox;
  late Box<SymptomLog> sleepBox;
  late Box<SymptomLog> sleepinessBox;
  late Box<SymptomLog> anxietyBox;
  late Box<BeckTestResult> beckTestResultBox;

  HiveLoader({
    required this.symptomLogAdapter,
    required this.beckTestResultAdapter,
  });

  @override
  @protected
  Future<void> doLoad() async {
    Hive.registerAdapter(symptomLogAdapter);
    Hive.registerAdapter(beckTestResultAdapter);
    await Hive.initFlutter();
    irritabilityBox = await Hive.openBox("symptom-irritability");
    sleepBox = await Hive.openBox("symptom-sleep");
    sleepinessBox = await Hive.openBox("symptom-sleepiness");
    anxietyBox = await Hive.openBox("symptom-anxiety");
    beckTestResultBox = await Hive.openBox("beck-test-results");
  }
}
