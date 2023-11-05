import 'package:easy_beck/common/day.dart';
import 'package:easy_beck/domain/symptoms/model/symptom_log.dart';
import 'package:hive/hive.dart';

const symptomLogTypeId = 100;

class SymptomLogAdapter extends TypeAdapter<SymptomLog> {
  @override
  SymptomLog read(BinaryReader reader) {
    final map = reader.readMap();
    final dateTime = map["dateTime"] as DateTime;
    final level = map["level"] as int;
    return SymptomLog(day: dateTime.toDay(), level: level);
  }

  @override
  int get typeId => symptomLogTypeId;

  @override
  void write(BinaryWriter writer, SymptomLog obj) {
    writer.writeMap(
        {
          "dateTime": obj.day.dateTime,
          "level": obj.level
        }
    );
  }
}
