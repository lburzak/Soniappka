import 'package:easy_beck/hive/id/int_identifier.dart';
import 'package:hive/hive.dart';

typedef IdCreator<S> = S Function(int value);

class AutoincrementService<T extends IntIdentifier> {
  final Box<int> _lastIdBox;
  final IdCreator<T> _creator;

  AutoincrementService(this._lastIdBox, this._creator);

  T nextId() {
    final lastId = _lastIdBox.get(T) ?? 0;
    return _creator(lastId + 1);
  }
}
