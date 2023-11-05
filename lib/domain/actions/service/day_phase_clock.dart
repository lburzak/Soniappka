import 'package:easy_beck/domain/actions/model/action.dart';

abstract interface class DayPhaseClock {
  DayPhase current();
  bool compare(DayPhase first, DayPhase second);
}
