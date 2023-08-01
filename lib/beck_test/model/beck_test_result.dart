import 'package:easy_beck/beck_test/model/beck_test_id.dart';

import 'depression_level.dart';

class BeckTestResult {
  final BeckTestId id;
  final int points;
  final DepressionLevel depressionLevel;
  final DateTime submissionDateTime;

  BeckTestResult copyWith({
    BeckTestId? id,
    int? points,
    DepressionLevel? depressionLevel,
    DateTime? submissionDateTime,
  }) {
    return BeckTestResult(
      id: id ?? this.id,
      points: points ?? this.points,
      depressionLevel: depressionLevel ?? this.depressionLevel,
      submissionDateTime: submissionDateTime ?? this.submissionDateTime,
    );
  }

  const BeckTestResult({
    required this.id,
    required this.points,
    required this.depressionLevel,
    required this.submissionDateTime,
  });
}
