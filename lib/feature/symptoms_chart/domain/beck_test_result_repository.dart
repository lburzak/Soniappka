import 'package:easy_beck/domain/beck_test/model/beck_test_result.dart';

abstract interface class BeckTestResultRepository {
  Stream<Iterable<BeckTestResult>> watchAll();
}
