import 'package:easy_beck/beck_test/model/beck_test_result.dart';

abstract interface class BeckTestResultRepository {
  Stream<Iterable<BeckTestResult>> watchAll();
}
