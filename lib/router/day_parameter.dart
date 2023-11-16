import 'package:easy_beck/domain/common/day.dart';
import 'package:intl/intl.dart';

final defaultDateFormat = DateFormat("yyyy-MM-dd");

class DayParameter {
  final Day day;

  DayParameter.fromString(String dayString)
      : day = switch (dayString) {
          "today" => DateTime.now().toDay(),
          _ => DateTime.parse(dayString.trim()).toDay(),
        };

  DayParameter.fromDay(this.day);

  String serialize() => defaultDateFormat.format(day.dateTime);
}
