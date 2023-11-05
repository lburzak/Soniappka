import 'package:easy_beck/domain/beck_test/model/beck_test_id.dart';
import 'package:easy_beck/hive/beck_test_result/day_hash.dart';

class DateTimeBeckTestId implements BeckTestId {
  final int value;

  DateTimeBeckTestId(DateTime dateTime) : value = dateTime.dayHashCode;

  DateTimeBeckTestId.fromDayHashCode(int dayHashCode) : value = dayHashCode;

  @override
  String serialize() {
    return value.toString();
  }
}
