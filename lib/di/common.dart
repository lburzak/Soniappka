import 'package:easy_beck/common/service/jiffy_calendar.dart';
import 'package:quiver/time.dart';

late final CommonDependencyGraph commonDependencyGraph =
    CommonDependencyGraph._();

class CommonDependencyGraph {
  late final clock = const Clock();
  late final calendar = JiffyCalendar();

  CommonDependencyGraph._();
}
