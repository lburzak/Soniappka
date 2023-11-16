import 'package:easy_beck/domain/actions/model/task.dart';

class DashboardState {
  final int? irritabilityLevel;
  final int? sleepinessLevel;
  final int? anxietyLevel;
  final List<Task> tasks;
  final DateTime day;
  final bool isToday;

  const DashboardState({
    this.irritabilityLevel,
    this.sleepinessLevel,
    this.anxietyLevel,
    required this.tasks,
    required this.day,
    required this.isToday,
  });
}
