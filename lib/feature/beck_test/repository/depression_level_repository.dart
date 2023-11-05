import 'package:easy_beck/feature/beck_test/model/depression_level.dart';

abstract interface class DepressionLevelRepository {
  Future<DepressionLevel> getDepressionLevelForPoints(int points);
}
