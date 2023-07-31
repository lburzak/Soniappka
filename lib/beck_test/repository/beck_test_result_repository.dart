import 'package:easy_beck/beck_test/model/beck_test_id.dart';
import 'package:easy_beck/beck_test/model/beck_test_result.dart';

abstract interface class BeckTestResultRepository {
  Future<BeckTestResult> insert(BeckTestResult beckTestResult);
  Future<BeckTestResult?> findById(BeckTestId id);
  BeckTestId createId();
}
