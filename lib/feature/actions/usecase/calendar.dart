import 'package:easy_beck/feature/actions/model/action.dart';
import 'package:jiffy/jiffy.dart';

abstract interface class Calendar {
  bool areSameWeek(DateTime first, DateTime second);

  bool areSameDay(DateTime first, DateTime second);

  DayOfWeek currentDayOfWeek();
}

class JiffyCalendar implements Calendar {
  @override
  bool areSameWeek(DateTime first, DateTime second) {
    return Jiffy.parseFromDateTime(first)
        .isSame(Jiffy.parseFromDateTime(second), unit: Unit.week);
  }

  @override
  bool areSameDay(DateTime first, DateTime second) {
    return Jiffy.parseFromDateTime(first)
        .isSame(Jiffy.parseFromDateTime(second), unit: Unit.day);
  }

  @override
  DayOfWeek currentDayOfWeek() {
    return DayOfWeek.values[Jiffy.now().dayOfWeek];
  }
}
