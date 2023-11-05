import 'package:easy_beck/domain/actions/model/action.dart';
import 'package:easy_beck/domain/actions/service/day_phase_clock.dart';

class DefaultDayPhaseClock implements DayPhaseClock {
  @override
  bool compare(DayPhase first, DayPhase second) {
    return first.isBefore(second);
  }

  @override
  DayPhase current() {
    final dateTime = DateTime.now();
    final hour = dateTime.hour;

    return switch (hour) {
      < 12 => DayPhase.morning,
      > 18 => DayPhase.evening,
      _ => DayPhase.day
    };
  }

}
