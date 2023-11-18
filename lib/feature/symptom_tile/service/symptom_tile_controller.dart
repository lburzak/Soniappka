import 'package:easy_beck/domain/common/day.dart';
import 'package:easy_beck/domain/symptoms/use_case/set_symptom_level.dart';
import 'package:easy_beck/domain/symptoms/use_case/watch_symptom_level.dart';

class SymptomTileController {
  final WatchSymptomLevel _watchSymptomLevel;
  final SetSymptomLevel _setSymptomLevel;
  final Day _day;

  const SymptomTileController({
    required WatchSymptomLevel watchSymptomLevel,
    required SetSymptomLevel setSymptomLevel,
    required Day day,
  })  : _watchSymptomLevel = watchSymptomLevel,
        _setSymptomLevel = setSymptomLevel,
        _day = day;

  Stream<int?> get state => _watchSymptomLevel(day: _day);

  void setSymptomLevel(int? level) => _setSymptomLevel(day: _day, level: level);
}
