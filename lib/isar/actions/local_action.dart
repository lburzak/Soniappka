import 'package:easy_beck/feature/actions/model/awesome_icon.dart';
import 'package:easy_beck/domain/actions/model/action.dart';
import 'package:easy_beck/domain/actions/model/action_id.dart';
import 'package:easy_beck/feature/actions/widget/task_tile.dart';
import 'package:isar/isar.dart';

part 'local_action.g.dart';

@collection
class LocalAction {
  Id? id;
  String? name;
  int? iconCodePoint;
  LocalRegularity? regularity;
}

@embedded
class LocalRegularity {
  @Enumerated(EnumType.name)
  LocalRegularityType? type;

  int? detail;

  LocalRegularity({
    this.type,
    this.detail,
  });
}

enum LocalRegularityType { daily, weekly, irregular }

class LocalActionId implements ActionId {
  final Id? value;

  LocalActionId(this.value);

  @override
  String serialize() {
    return value.toString();
  }
}

extension LocalActionSerialization on LocalAction {
  Action deserialize() {
    return Action(
        id: LocalActionId(id),
        name: name ?? "Unnamed",
        icon: iconCodePoint?.let((it) => AwesomeIcon.fromCodePoint(it)),
        regularity: regularity.deserialize());
  }
}

extension LocalRegularitySerialization on LocalRegularity? {
  Regularity deserialize() =>
      switch (this?.type) {
        LocalRegularityType.irregular || null => Irregular(),
        LocalRegularityType.daily => Daily(
            dayPhase: this?.detail?.let((it) => DayPhase.values[it])),
        LocalRegularityType.weekly => Weekly(
            dayOfWeek:
            this?.detail?.let((it) => DayOfWeek.values[it])),
      };
}

extension RegularitySerialization on Regularity {
  LocalRegularity serialize() => LocalRegularity(
      type: switch (this) {
        Irregular() => LocalRegularityType.irregular,
        Daily() => LocalRegularityType.daily,
        Weekly() => LocalRegularityType.weekly
      },
      detail: switch (this) {
        Irregular() => null,
        Daily(dayPhase: final dayPhase) => dayPhase?.index,
        Weekly(dayOfWeek: final dayOfWeek) => dayOfWeek?.index
      });
}

extension ActionSerialization on Action {
  LocalAction serialize() {
    return LocalAction()
      ..id = id.castOrNull<LocalActionId>()?.value
      ..regularity = regularity.serialize()
      ..name = name
      ..iconCodePoint = castOrNull<AwesomeIcon>()?.codePoint;
  }
}
