import 'package:easy_beck/dashboard/dashboard_view_model.dart';
import 'package:easy_beck/dashboard/usecase/check_if_test_was_filled_today.dart';
import 'package:rxdart/rxdart.dart';

class DashboardController {
  final CheckIfTestWasFilledToday _checkIfTestWasFilledToday;

  late final viewModel = _checkIfTestWasFilledToday()
      .asStream()
      .map((isFilled) => DashboardViewModel(isTodayTestFilled: isFilled))
      .startWith(const DashboardViewModel(isTodayTestFilled: false));

  DashboardController(this._checkIfTestWasFilledToday);
}
