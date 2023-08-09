import 'package:easy_beck/beck_test/repository/beck_test_result_repository.dart';
import 'package:easy_beck/common/day.dart';
import 'package:quiver/time.dart';

class ObserveIfTestWasFilledToday {
  final Clock _clock;
  final BeckTestResultRepository _repository;

  ObserveIfTestWasFilledToday(this._clock, this._repository);

  Stream<bool> call() => _repository
      .observeByDay(_clock.now().toDay())
      .map((event) => event != null);
}
