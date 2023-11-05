import 'package:easy_beck/domain/common/identifier.dart';

class IntIdentifier implements Identifier {
  final int value;

  const IntIdentifier(this.value);

  @override
  String serialize() {
    return value.toString();
  }
}
