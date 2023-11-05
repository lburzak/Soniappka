import 'package:easy_beck/domain/actions/model/action.dart';
import 'package:easy_beck/domain/actions/service/calendar.dart';
import 'package:jiffy/jiffy.dart';

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
