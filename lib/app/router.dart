import 'package:easy_beck/beck_calendar/beck_calendar_controller.dart';
import 'package:easy_beck/beck_calendar/beck_calendar_view.dart';
import 'package:easy_beck/beck_test/data/in_memory_beck_test_result_repository.dart';
import 'package:easy_beck/beck_test/data/json_file_beck_repository.dart';
import 'package:easy_beck/beck_test/repository/beck_test_result_repository.dart';
import 'package:easy_beck/beck_test/repository/depression_level_repository.dart';
import 'package:easy_beck/beck_test/repository/question_repository.dart';
import 'package:easy_beck/beck_test/service/beck_test_controller.dart';
import 'package:easy_beck/beck_test/service/beck_test_router.dart';
import 'package:easy_beck/beck_test/ui/beck_test_result_page.dart';
import 'package:easy_beck/beck_test/ui/beck_test_view.dart';
import 'package:easy_beck/beck_test/usecase/get_beck_test_result.dart';
import 'package:easy_beck/beck_test/usecase/submit_beck_test.dart';
import 'package:easy_beck/dashboard/dashboard.dart';
import 'package:easy_beck/dashboard/dashboard_controller.dart';
import 'package:easy_beck/dashboard/usecase/check_if_test_was_filled_today.dart';
import 'package:easy_beck/mood_tracker/data/in_memory_mood_log_repository.dart';
import 'package:easy_beck/mood_tracker/domain/repository/mood_log_repository.dart';
import 'package:easy_beck/mood_tracker/domain/usecase/log_mood.dart';
import 'package:easy_beck/mood_tracker/mood_picker.dart';
import 'package:easy_beck/mood_tracker/service/mood_tracker_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:kiwi/kiwi.dart';
import 'package:quiver/time.dart';

class BeckTestDomainContainer extends KiwiContainer {
  BeckTestDomainContainer() : super.scoped() {
    registerSingleton((container) => JsonFileBeckRepository());
    registerSingleton<QuestionRepository>(
        (container) => container<JsonFileBeckRepository>());
    registerSingleton<DepressionLevelRepository>(
        (container) => container<JsonFileBeckRepository>());
    registerSingleton<BeckTestResultRepository>(
        (container) => InMemoryBeckTestResultRepository());
  }
}

class BeckTestResultContainer extends KiwiContainer {
  BeckTestResultContainer() : super.scoped() {
    registerFactory(
        (container) => GetBeckTestResult(beckTestDomainContainer()));
  }
}

class BeckTestQuestionnaireContainer extends KiwiContainer {
  final BuildContext _context;

  BeckTestQuestionnaireContainer(this._context) : super.scoped() {
    registerFactory<BeckTestRouter>((container) => GoBeckTestRouter(_context));
    registerFactory((container) => const Clock());
    registerFactory((container) => SubmitBeckTest(
        beckTestDomainContainer(), beckTestDomainContainer(), container()));
    registerFactory((container) => BeckTestController(
        beckTestDomainContainer(), container(), container()));
  }
}

class DashboardContainer extends KiwiContainer {
  DashboardContainer() : super.scoped() {
    registerFactory((container) => const Clock());
    registerFactory((container) =>
        CheckIfTestWasFilledToday(container(), beckTestDomainContainer()));
    registerFactory((container) => DashboardController(container()));
  }
}

class BeckCalendarContainer extends KiwiContainer {
  BeckCalendarContainer() : super.scoped() {
    registerFactory(
        (container) => BeckCalendarController(beckTestDomainContainer()));
    registerFactory<BeckCalendarViewBuilder>(
        (container) => (context) => BeckCalendarView(
              viewModel: container<BeckCalendarController>().viewModel,
            ));
  }
}

class MoodTrackerContainer extends KiwiContainer {
  MoodTrackerContainer() : super.scoped() {
    registerFactory((container) => const Clock());
    registerFactory<MoodLogRepository>((container) => InMemoryMoodLogRepository(container()));
    registerFactory((container) => LogMood(container(), container()));
    registerFactory((container) => MoodTrackerBloc(container()));
  }
}

final beckTestResultContainer = BeckTestResultContainer();
final beckTestDomainContainer = BeckTestDomainContainer();
final dashboardContainer = DashboardContainer();
final beckCalendarContainer = BeckCalendarContainer();
final moodTrackerContainer = MoodTrackerContainer();

final router = GoRouter(routes: [
  GoRoute(
      path: "/",
      builder: (context, state) {
        final bloc = moodTrackerContainer<MoodTrackerBloc>();
        return Dashboard(
          viewModel: dashboardContainer<DashboardController>().viewModel,
          calendarBuilder: beckCalendarContainer(),
          moodPickerBuilder: (context) => MoodPicker(
            events: bloc,
            state: bloc.stream,
          ),
        );
      }),
  GoRoute(
      path: "/beck-test",
      builder: (context, state) {
        final BeckTestController(:state, :submit, :selectAnswer) =
            BeckTestQuestionnaireContainer(context).resolve();

        return BeckTestView(
            state: state, onSubmit: submit, onAnswerSelected: selectAnswer);
      }),
  GoRoute(
      path: "/beck-test/:beckTestId/result",
      builder: (context, state) {
        final id =
            InMemoryBeckTestId.deserialize(state.pathParameters["beckTestId"]!);
        return BeckTestResultPage(
            getBeckTestResult: beckTestResultContainer(), id: id);
      })
]);
