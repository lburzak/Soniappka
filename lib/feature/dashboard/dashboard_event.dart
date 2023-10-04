import 'package:easy_beck/feature/actions/model/task.dart';
import 'package:easy_beck/feature/dashboard/symptom_type.dart';

sealed class DashboardEvent {
  const DashboardEvent();
}

class SetLevel extends DashboardEvent {
  final int level;
  final SymptomType symptomType;

  const SetLevel({
    required this.level,
    required this.symptomType,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SetLevel && runtimeType == other.runtimeType &&
              level == other.level;

  @override
  int get hashCode => level.hashCode;
}

class UnsetLevel extends DashboardEvent {
  final SymptomType symptomType;

  const UnsetLevel({
    required this.symptomType,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is UnsetLevel && runtimeType == other.runtimeType &&
              symptomType == other.symptomType;

  @override
  int get hashCode => symptomType.hashCode;
}

class TaskToggled extends DashboardEvent {
  final Task task;

  const TaskToggled({
    required this.task,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskToggled &&
          runtimeType == other.runtimeType &&
          task == other.task;

  @override
  int get hashCode => task.hashCode;
}

class ShowTaskCreator extends DashboardEvent {

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShowTaskCreator && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
