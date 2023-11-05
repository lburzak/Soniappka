import 'package:easy_beck/feature/beck_test/data/hive_beck_test_result_repository.dart';
import 'package:easy_beck/feature/beck_test/model/beck_test_result.dart';
import 'package:easy_beck/feature/beck_test/model/depression_level.dart';
import 'package:hive/hive.dart';

const beckTestResultTypeId = 101;

class BeckTestResultAdapter extends TypeAdapter<BeckTestResult> {
  @override
  BeckTestResult read(BinaryReader reader) {
    final map = reader.readMap();
    final submissionDateTime = map["submissionDateTime"] as DateTime;
    final id = DateTimeBeckTestId(submissionDateTime);
    final points = map["points"] as int;
    final depressionLevel = deserializeDepressionLevel(map["depressionLevel"]);

    return BeckTestResult(
        id: id,
        points: points,
        depressionLevel: depressionLevel,
        submissionDateTime: submissionDateTime);
  }

  @override
  int get typeId => beckTestResultTypeId;

  @override
  void write(BinaryWriter writer, BeckTestResult obj) {
    writer.writeMap({
      "submissionDateTime": obj.submissionDateTime,
      "points": obj.points,
      "depressionLevel": serializeDepressionLevel(obj.depressionLevel)
    });
  }

  int serializeDepressionLevel(DepressionLevel depressionLevel) =>
      switch (depressionLevel) {
        DepressionLevel.none => 0,
        DepressionLevel.mild => 1,
        DepressionLevel.moderate => 2,
        DepressionLevel.severe => 3
      };

  DepressionLevel deserializeDepressionLevel(int value) => switch (value) {
        1 => DepressionLevel.mild,
        2 => DepressionLevel.moderate,
        3 => DepressionLevel.severe,
        _ => DepressionLevel.none
      };
}
