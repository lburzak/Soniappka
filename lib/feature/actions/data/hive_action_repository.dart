import 'package:easy_beck/feature/actions/model/action.dart';
import 'package:easy_beck/feature/actions/model/action_id.dart';
import 'package:easy_beck/feature/actions/repository/action_repository.dart';
import 'package:easy_beck/hive/id/autoincrement_service.dart';
import 'package:easy_beck/feature/actions/data/hive_action_id.dart';
import 'package:hive/hive.dart';

class HiveActionRepository implements ActionRepository {
  final AutoincrementService<HiveActionId> _autoincrementService;
  final Box<Action> _actionsBox;

  @override
  Future<void> upsertAction(Action action) async {
    final currentId = action.id;
    final HiveActionId id = currentId is HiveActionId
        ? currentId
        : HiveActionId(currentId.serialize().hashCode);

    _actionsBox.put(id, action.copyWith(id: id));
  }

  @override
  Stream<List<Action>> watchActiveActions() async* {
    yield _actionsBox.values.toList();
    yield* _actionsBox.watch().map((event) => _actionsBox.values.toList());
  }

  @override
  ActionId createId() {
    return _autoincrementService.nextId();
  }

  const HiveActionRepository({
    required AutoincrementService<HiveActionId> autoincrementService,
    required Box<Action> actionsBox,
  })  : _autoincrementService = autoincrementService,
        _actionsBox = actionsBox;
}
