import 'package:easy_beck/common/day.dart';
import 'package:easy_beck/domain/symptoms/error/invalid_symptom_level_error.dart';

class SymptomLog {
  final Day day;
  final int level;

  SymptomLog({
    required this.day,
    required this.level,
  }) {
    _assertSymptomLevelIsValid(level);
  }

  void _assertSymptomLevelIsValid(int level) {
    if (level < 1 && level > 5) {
      throw InvalidSymptomLevelError(level: level);
    }
  }
}
