import 'package:easy_beck/feature/actions/awesome_icon.dart';
import 'package:easy_beck/feature/actions/model/action.dart';
import 'package:easy_beck/feature/actions/model/action_id.dart';
import 'package:easy_beck/feature/actions/repository/action_repository.dart';
import 'package:flutter/material.dart' as material;

class IntActionId implements ActionId {
  final int index;

  IntActionId(this.index);

  @override
  String serialize() {
    return index.toString();
  }

}

class InMemoryActionRepository implements ActionRepository {
  int _lastId = 0;
  final List<Action> _actions = [
    Action(id: IntActionId(0), name: "Test Becka", icon: const AwesomeIcon(material.Icons.medication), regularity: Irregular()),
    Action(id: IntActionId(1), name: "Test Becka", icon: const AwesomeIcon(material.Icons.one_k), regularity: Irregular()),
    Action(id: IntActionId(2), name: "Test Becka", icon: const AwesomeIcon(material.Icons.abc), regularity: Irregular()),
  ];

  @override
  ActionId createId() {
    return IntActionId(_lastId++);
  }

  @override
  Future<void> upsertAction(Action action) async {
    _actions.add(action);
  }

  @override
  Stream<List<Action>> watchActiveActions() {
    return Stream.value(_actions);
  }

}
