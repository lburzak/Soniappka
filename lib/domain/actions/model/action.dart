import 'package:easy_beck/domain/actions/model/action_icon.dart';
import 'package:easy_beck/domain/actions/model/action_id.dart';

sealed class Regularity {
  const Regularity();
}

class Weekly extends Regularity {
  final DayOfWeek? dayOfWeek;

  const Weekly({
    required this.dayOfWeek,
  });
}

class Daily extends Regularity {
  final DayPhase? dayPhase;

  const Daily({
    required this.dayPhase,
  });
}

class Irregular extends Regularity {}

enum DayPhase { morning, day, evening }

enum DayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday
}

class Action {
  final ActionId id;
  final String name;
  final ActionIcon? icon;
  final Regularity regularity;

  const Action({required this.id,
    required this.name,
    required this.icon,
    required this.regularity});

  Action copyWith({
    ActionId? id,
    String? name,
    ActionIcon? icon,
    Regularity? regularity,
  }) {
    return Action(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      regularity: regularity ?? this.regularity,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Action &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          icon == other.icon &&
          regularity == other.regularity;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ icon.hashCode ^ regularity.hashCode;
}

extension DayPhaseExtension on DayPhase {
  bool isBefore(DayPhase dayPhase) =>
      DayPhase.values.indexOf(dayPhase) < DayPhase.values.indexOf(this);
}

extension DayOfWeekExtension on DayOfWeek {
  bool isBefore(DayOfWeek dayOfWeek) =>
      DayOfWeek.values.indexOf(dayOfWeek) < DayOfWeek.values.indexOf(this);
}
