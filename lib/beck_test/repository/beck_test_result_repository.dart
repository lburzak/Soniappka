import 'package:easy_beck/beck_test/model/beck_test_id.dart';
import 'package:easy_beck/beck_test/model/beck_test_result.dart';
import 'package:easy_beck/common/day.dart';

abstract interface class BeckTestResultRepository {
  Future<BeckTestResult> insert(BeckTestResult beckTestResult);
  Future<BeckTestResult?> findById(BeckTestId id);
  Stream<BeckTestResult?> observeByDay(Day day);
  Stream<List<BeckTestResult>> observeAll();
  BeckTestId createId();
}
