import 'package:collection/collection.dart';
import 'package:easy_beck/domain/actions/model/action_id.dart';
import 'package:easy_beck/domain/actions/repository/action_completion_repository.dart';
import 'package:rxdart/rxdart.dart';

class _Completion {
  final ActionId actionId;
  final DateTime dateTime;

  const _Completion({
    required this.actionId,
    required this.dateTime,
  });
}

class InMemoryActionCompletionRepository implements ActionCompletionRepository {
  List<_Completion> _completions = [];
  final subject = PublishSubject<ActionId>();

  @override
  void addCompletion(ActionId actionId, DateTime dateTime) {
    _completions.add(_Completion(actionId: actionId, dateTime: dateTime));
    subject.add(actionId);
  }

  @override
  DateTime? getDateTimeOfLastCompletion(ActionId actionId) {
    return _completions
        .where((element) => element.actionId == actionId)
        .map((e) => e.dateTime)
        .sorted()
        .lastOrNull;
  }

  @override
  void removeLastCompletion(ActionId actionId) {
    final last = getDateTimeOfLastCompletion(actionId);
    _completions = _completions
        .whereNot((element) =>
            element.actionId == actionId && element.dateTime == last)
        .toList();
    subject.add(actionId);
  }

  @override
  Stream<DateTime?> watchDateTimeOfLastCompletion(ActionId actionId) async* {
    yield getDateTimeOfLastCompletion(actionId);
    yield* subject
        .where((event) => event == actionId)
        .map((event) => getDateTimeOfLastCompletion(actionId));
  }
}
