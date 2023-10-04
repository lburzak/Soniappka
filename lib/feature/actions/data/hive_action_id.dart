import 'package:easy_beck/feature/actions/model/action_id.dart';
import 'package:easy_beck/hive/id/int_identifier.dart';

class HiveActionId extends IntIdentifier implements ActionId {
  const HiveActionId(super.value);
}
