import 'package:easy_beck/domain/beck_test/model/beck_test_id.dart';

class NoId implements BeckTestId {
  @override
  String serialize() {
    return "0";
  }
}
