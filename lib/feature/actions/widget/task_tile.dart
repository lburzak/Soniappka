import 'package:easy_beck/feature/actions/model/awesome_icon.dart';
import 'package:easy_beck/domain/actions/model/action.dart';
import 'package:easy_beck/domain/actions/model/action_icon.dart';
import 'package:easy_beck/domain/actions/model/task.dart';
import 'package:easy_beck/feature/actions/widget/completable_tile.dart';
import 'package:easy_beck/common/ui/optional_builder.dart';
import 'package:easy_beck/l10n/localizations.dart';
import 'package:easy_beck/theme/colors.dart';
import 'package:easy_beck/theme/theme_getter.dart';
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
      style: TextStyle(color: context.theme.colors.inactive),
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
        DayPhase.day => context.l10n.dayPhaseDay,
        DayPhase.morning => context.l10n.dayPhaseMorning,
        DayPhase.evening => context.l10n.dayPhaseEvening,
        null => context.l10n.dayPhaseAllDay
      };

  String _formatDayOfWeek(BuildContext context, DayOfWeek? dayOfWeek) =>
      switch (dayOfWeek) {
        DayOfWeek.monday => context.l10n.dayOfWeekMonday,
        DayOfWeek.tuesday => context.l10n.dayOfWeekTuesday,
        DayOfWeek.wednesday => context.l10n.dayOfWeekWednesday,
        DayOfWeek.thursday => context.l10n.dayOfWeekThursday,
        DayOfWeek.friday => context.l10n.dayOfWeekFriday,
        DayOfWeek.saturday => context.l10n.dayOfWeekSaturday,
        DayOfWeek.sunday => context.l10n.dayOfWeekSunday,
        null => context.l10n.dayOfWeekAny
      };

  String _formatTimeAgo(BuildContext context, DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }

    final days = DateTime.now().difference(dateTime).inDays;

    if (days == 0) {
      return context.l10n.today;
    }

    return context.l10n.nDaysAgo(days);
  }
}

extension CastOrNull on Object {
  T? castOrNull<T>() => this is T ? this as T : null;
}

extension ObjectExt<T> on T {
  R let<R>(R Function(T it) op) => op(this);
}
