import 'package:easy_beck/feature/actions/model/awesome_icon.dart';
import 'package:easy_beck/domain/actions/model/action.dart';
import 'package:easy_beck/domain/actions/model/action_id.dart';

class BeckTestActionId implements ActionId {
  @override
  String serialize() {
    return "beckTest";
  }
}

final beckTestAction = Action(id: BeckTestActionId(),
    name: "Test Becka",
    icon: AwesomeIcon.fromCodePoint(62104),
    regularity: Irregular());
