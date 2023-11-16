import 'package:easy_beck/domain/actions/model/action.dart';
import 'package:easy_beck/domain/common/day.dart';

abstract interface class Calendar {
  bool areSameWeek(DateTime first, DateTime second);

  bool areSameDay(DateTime first, DateTime second);

  bool isToday(Day day);

  DayOfWeek currentDayOfWeek();
}
