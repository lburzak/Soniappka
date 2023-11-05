import 'package:quiver/time.dart';

class Day {
  final int year;
  final int month;
  final int day;
  late final dateTime = DateTime(year, month, day);

  Day(this.year, this.month, this.day);

  Day.fromDateTime(DateTime dateTime)
      : year = dateTime.year,
        month = dateTime.month,
        day = dateTime.day;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is Day &&
              runtimeType == other.runtimeType &&
              year == other.year &&
              month == other.month &&
              day == other.day) ||
          (other is DateTime &&
              year == other.year &&
              month == other.month &&
              day == other.day);

  @override
  int get hashCode => year.hashCode ^ month.hashCode ^ day.hashCode;

  @override
  String toString() {
    return 'Day{year: $year, month: $month, day: $day}';
  }
}

extension ToDay on DateTime {
  Day toDay() => Day.fromDateTime(this);
}

extension Today on Clock {
  Day today() => now().toDay();
}
