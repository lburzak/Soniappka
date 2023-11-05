import 'package:easy_beck/domain/actions/model/action_id.dart';

abstract interface class ActionCompletionRepository {
  DateTime? getDateTimeOfLastCompletion(ActionId actionId);
  Stream<DateTime?> watchDateTimeOfLastCompletion(ActionId actionId);
  void addCompletion(ActionId actionId, DateTime dateTime);
  void removeLastCompletion(ActionId actionId);
}
