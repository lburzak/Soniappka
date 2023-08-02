import 'package:easy_beck/beck_calendar/beck_calendar_view.dart';
import 'package:easy_beck/beck_calendar/beck_calendar_view_model.dart';
import 'package:easy_beck/beck_test/model/beck_test_result.dart';
import 'package:easy_beck/beck_test/repository/beck_test_result_repository.dart';

class BeckCalendarController {
  final BeckTestResultRepository _beckTestResultRepository;
  late final Stream<BeckCalendarViewModel> viewModel = _beckTestResultRepository
      .observeAll()
      .map((event) => listOfResultsToModel(event));

  BeckCalendarController(this._beckTestResultRepository);

  static BeckCalendarViewModel listOfResultsToModel(
      List<BeckTestResult> results) {
    final entries =
        results.map((e) => MapEntry(e.submissionDateTime.dayHashCode, e));
    return BeckCalendarViewModel(testResults: Map.fromEntries(entries));
  }
}
