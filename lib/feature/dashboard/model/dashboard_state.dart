import 'package:easy_beck/feature/actions/model/task.dart';

class DashboardState {
  final int? irritabilityLevel;
  final int? sleepinessLevel;
  final int? anxietyLevel;
  final List<Task> tasks;

  const DashboardState(
      {required this.irritabilityLevel,
      required this.sleepinessLevel,
      required this.anxietyLevel,
      required this.tasks});
}
