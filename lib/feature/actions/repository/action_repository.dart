import 'package:easy_beck/feature/actions/model/action.dart';
import 'package:easy_beck/feature/actions/model/action_id.dart';

abstract interface class ActionRepository {
  Stream<List<Action>> watchActiveActions();
  Future<void> upsertAction(Action action);
  ActionId createId();
}
