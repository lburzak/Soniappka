import 'package:easy_beck/feature/actions/model/action.dart';

enum TaskStatus {
  completed,
  pending,
  failed
}

class Task {
  final Action action;
  final DateTime? lastCompleted;
  final TaskStatus status;

  const Task({
    required this.action,
    required this.lastCompleted,
    required this.status,
  });
}
