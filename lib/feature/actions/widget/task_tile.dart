import 'package:easy_beck/feature/actions/awesome_icon.dart';
import 'package:easy_beck/feature/actions/model/action.dart';
import 'package:easy_beck/feature/actions/model/action_icon.dart';
import 'package:easy_beck/feature/actions/model/task.dart';
import 'package:easy_beck/feature/actions/widget/completable_tile.dart';
import 'package:easy_beck/feature/actions/widget/optional_builder.dart';
import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final void Function() onToggle;

  const TaskTile({super.key, required this.task, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return CompletableTile(
        title: task.action.name,
        icon: task.action.icon?.let((it) => TaskIcon(icon: it)),
        hint: TaskHint(
            regularity: task.action.regularity,
            lastCompleted: task.lastCompleted),
        completed: task.status == TaskStatus.completed,
        onTap: onToggle);
  }
}

class TaskIcon extends StatelessWidget {
  final ActionIcon icon;

  const TaskIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return OptionalBuilder(
        value: icon.castOrNull<AwesomeIcon>(),
        builder: (context, value) => Icon(value.iconData, size: 42,));
  }
}

class TaskHint extends StatelessWidget {
  final Regularity regularity;
  final DateTime? lastCompleted;

  const TaskHint(
      {super.key, required this.regularity, required this.lastCompleted});

  @override
  Widget build(BuildContext context) {
    return Text(
      _buildText(context),
      style: const TextStyle(color: Colors.grey),
    );
  }

  String _buildText(BuildContext context) {
    return switch (regularity) {
      Daily(dayPhase: final dayPhase) => _formatDayPhase(context, dayPhase),
      Weekly(dayOfWeek: final dayOfWeek) => _formatDayOfWeek(context, dayOfWeek),
      Irregular() => _formatTimeAgo(context, lastCompleted)
    };
  }

  String _formatDayPhase(BuildContext context, DayPhase? dayPhase) =>
      switch (dayPhase) {
        DayPhase.day => "W ciągu dnia",
        DayPhase.morning => "Rano",
        DayPhase.evening => "Wieczorem",
        null => "Codziennie"
      };

  String _formatDayOfWeek(BuildContext context, DayOfWeek? dayOfWeek) =>
      switch (dayOfWeek) {
        DayOfWeek.monday => "Poniedziałek",
        DayOfWeek.tuesday => "Wtorek",
        DayOfWeek.wednesday => "Środa",
        DayOfWeek.thursday => "Czwartek",
        DayOfWeek.friday => "Piątek",
        DayOfWeek.saturday => "Sobota",
        DayOfWeek.sunday => "Niedziela",
        null => "W tygodniu"
      };

  String _formatTimeAgo(BuildContext context, DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }

    final days = DateTime.now().difference(dateTime).inDays;
    return "$days dni temu";
  }
}

extension CastOrNull on Object {
  T? castOrNull<T>() => this is T ? this as T : null;
}

extension ObjectExt<T> on T {
  R let<R>(R Function(T it) op) => op(this);
}
