import 'package:easy_beck/feature/beck_test/model/beck_test_result.dart';
import 'package:easy_beck/feature/beck_test/repository/beck_test_result_repository.dart';
import 'package:easy_beck/feature/beck_test/repository/depression_level_repository.dart';
import 'package:quiver/time.dart';

class SubmitBeckTest {
  final DepressionLevelRepository _depressionLevelRepository;
  final BeckTestResultRepository _beckTestResultRepository;
  final Clock _clock;

  SubmitBeckTest(this._depressionLevelRepository,
      this._beckTestResultRepository, this._clock);

  Future<BeckTestResult> call(int points) async {
    final depressionLevel =
        await _depressionLevelRepository.getDepressionLevelForPoints(points);

    return await _beckTestResultRepository.insert(BeckTestResult(
        id: _beckTestResultRepository.createId(),
        submissionDateTime: _clock.now(),
        points: points,
        depressionLevel: depressionLevel));
  }
}
