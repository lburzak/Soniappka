import 'package:easy_beck/beck_test/repository/beck_test_result_repository.dart';
import 'package:easy_beck/common/day.dart';

class CheckBeckTestStatusForDay {
  final BeckTestResultRepository _beckTestResultRepository;

  Future<bool> call(Day day) async {
    final result = await _beckTestResultRepository
        .observeByDay(day)
        .first;

    return result != null;
  }

  const CheckBeckTestStatusForDay({
    required BeckTestResultRepository beckTestResultRepository,
  }) : _beckTestResultRepository = beckTestResultRepository;
}
