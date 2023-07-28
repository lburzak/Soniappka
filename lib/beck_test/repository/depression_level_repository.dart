import 'package:easy_beck/beck_test/model/depression_level.dart';

abstract interface class DepressionLevelRepository {
  Future<DepressionLevel> getDepressionLevelForPoints(int points);
}
