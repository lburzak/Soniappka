import 'package:easy_beck/feature/beck_test/model/identifier.dart';

class IntIdentifier implements Identifier {
  final int value;

  const IntIdentifier(this.value);

  @override
  String serialize() {
    return value.toString();
  }
}
