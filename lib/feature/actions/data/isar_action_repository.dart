import 'package:easy_beck/feature/actions/data/local_action.dart';
import 'package:easy_beck/feature/actions/model/action.dart';
import 'package:easy_beck/feature/actions/model/action_id.dart';
import 'package:easy_beck/feature/actions/repository/action_repository.dart';
import 'package:isar/isar.dart';

class IsarActionRepository implements ActionRepository {
  final IsarCollection<LocalAction> actions;

  IsarActionRepository(this.actions);

  @override
  ActionId createId() {
    return LocalActionId(Isar.autoIncrement);
  }

  @override
  Future<void> upsertAction(Action action) async {
    actions.put(action.serialize());
  }

  @override
  Stream<List<Action>> watchActiveActions() {
    return actions.filter().idIsNotNull().watch(fireImmediately: true).map(
        (actions) => actions.map((action) => action.deserialize()).toList());
  }
}
