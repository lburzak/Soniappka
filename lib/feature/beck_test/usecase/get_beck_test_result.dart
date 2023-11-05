import 'package:easy_beck/feature/beck_test/model/beck_test_id.dart';
import 'package:easy_beck/feature/beck_test/model/beck_test_result.dart';
import 'package:easy_beck/feature/beck_test/repository/beck_test_result_repository.dart';

class GetBeckTestResult {
  final BeckTestResultRepository _repository;

  GetBeckTestResult(this._repository);

  Future<BeckTestResult?> invoke(BeckTestId id) => _repository.findById(id);
}
