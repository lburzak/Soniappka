import 'package:easy_beck/beck_test/repository/beck_test_result_repository.dart';
import 'package:easy_beck/common/day.dart';
import 'package:quiver/time.dart';

class CheckIfTestWasFilledToday {
  final Clock _clock;
  final BeckTestResultRepository _repository;

  CheckIfTestWasFilledToday(this._clock, this._repository);

  Future<bool> call() async {
    final result = await _repository.findByDay(_clock.now().toDay());
    return result != null;
  }
}
