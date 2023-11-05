import 'package:easy_beck/domain/actions/model/action.dart';

abstract interface class Calendar {
  bool areSameWeek(DateTime first, DateTime second);

  bool areSameDay(DateTime first, DateTime second);

  DayOfWeek currentDayOfWeek();
}
