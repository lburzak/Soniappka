import 'package:easy_beck/common/day.dart';
import 'package:easy_beck/domain/beck_test/model/beck_test_id.dart';
import 'package:easy_beck/domain/beck_test/model/beck_test_result.dart';

abstract interface class BeckTestResultRepository {
  Future<BeckTestResult> insert(BeckTestResult beckTestResult);
  Future<BeckTestResult?> findById(BeckTestId id);
  Stream<BeckTestResult?> observeByDay(Day day);
  Stream<Iterable<BeckTestResult>> watchAll();
  Stream<DateTime?> watchSubmissionDateTimeOfLast();
  BeckTestId createId();
}
