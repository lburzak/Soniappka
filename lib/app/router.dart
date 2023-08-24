import 'package:easy_beck/app/app_router.dart';
import 'package:easy_beck/app/bottom_bar.dart';
import 'package:easy_beck/beck_calendar/beck_calendar_controller.dart';
import 'package:easy_beck/beck_calendar/beck_calendar_view.dart';
import 'package:easy_beck/beck_test/data/hive_beck_test_result_repository.dart';
import 'package:easy_beck/beck_test/data/in_memory_beck_test_result_repository.dart';
import 'package:easy_beck/beck_test/data/json_file_beck_repository.dart';
import 'package:easy_beck/beck_test/repository/beck_test_result_repository.dart'
    as beck_test;
import 'package:easy_beck/common/loader.dart';
import 'package:easy_beck/feature/symptom_page/irritability_page.dart';
import 'package:easy_beck/feature/symptom_page/symptom_page.dart';
import 'package:easy_beck/feature/symptoms_chart/domain/beck_test_result_repository.dart'
    as symptoms_chart;
import 'package:easy_beck/beck_test/repository/depression_level_repository.dart';
import 'package:easy_beck/beck_test/repository/question_repository.dart';
import 'package:easy_beck/beck_test/service/beck_test_controller.dart';
import 'package:easy_beck/beck_test/service/beck_test_router.dart';
import 'package:easy_beck/beck_test/ui/beck_test_result_page.dart';
import 'package:easy_beck/beck_test/ui/beck_test_view.dart';
import 'package:easy_beck/beck_test/usecase/get_beck_test_result.dart';
import 'package:easy_beck/beck_test/usecase/submit_beck_test.dart';
import 'package:easy_beck/common/ui/typed_widget_builder.dart';
import 'package:easy_beck/feature/dashboard/dashboard.dart';
import 'package:easy_beck/dashboard/dashboard_controller.dart';
import 'package:easy_beck/feature/beck_test_button/domain/check_if_test_was_filled_today.dart';
import 'package:easy_beck/feature/beck_test_button/ui/beck_test_button.dart';
import 'package:easy_beck/feature/symptom_prompt/data/hive_symptom_repository.dart';
import 'package:easy_beck/feature/symptom_prompt/domain/log_symptom.dart';
import 'package:easy_beck/feature/symptom_prompt/domain/observe_symptom_has_value_today.dart';
import 'package:easy_beck/feature/symptom_prompt/domain/symptom_repository.dart';
import 'package:easy_beck/feature/symptom_prompt/ui/anxiety_prompt.dart';
import 'package:easy_beck/feature/symptom_prompt/ui/irritability_prompt.dart';
import 'package:easy_beck/feature/symptom_prompt/ui/sleep_prompt.dart';
import 'package:easy_beck/feature/symptom_prompt/ui/sleepiness_prompt.dart';
import 'package:easy_beck/feature/symptoms_chart/domain/symptom_log_repository.dart';
import 'package:easy_beck/feature/symptoms_chart/service/symptoms_chart_controller.dart';
import 'package:easy_beck/feature/symptoms_chart/ui/symptoms_chart.dart';
import 'package:easy_beck/hive/adapter/beck_test_result_adapter.dart';
import 'package:easy_beck/hive/adapter/symptom_log_adapter.dart';
import 'package:easy_beck/hive/hive_loader.dart';
import 'package:easy_beck/mood_tracker/data/in_memory_mood_log_repository.dart';
import 'package:easy_beck/mood_tracker/domain/repository/mood_log_repository.dart';
import 'package:easy_beck/mood_tracker/domain/usecase/log_mood.dart';
import 'package:easy_beck/mood_tracker/mood_picker.dart';
import 'package:easy_beck/mood_tracker/service/mood_tracker_bloc.dart';
import 'package:easy_beck/page/journal/journal_page.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:quiver/time.dart';

class BeckTestDomainContainer extends KiwiContainer {
  BeckTestDomainContainer() : super.scoped() {
    registerSingleton((container) => JsonFileBeckRepository());
    registerSingleton<QuestionRepository>(
        (container) => container<JsonFileBeckRepository>());
    registerSingleton<DepressionLevelRepository>(
        (container) => container<JsonFileBeckRepository>());
    registerSingleton<beck_test.BeckTestResultRepository>(
        (container) => HiveBeckTestResultRepository(hiveContainer()));
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
    registerFactory<WidgetBuilder>((container) => (BuildContext context) {
          final BeckTestController(:state, :submit, :selectAnswer) =
              container();

          return BeckTestView(
              state: state, onSubmit: submit, onAnswerSelected: selectAnswer);
        });
  }
}

class DashboardContainer extends KiwiContainer {
  DashboardContainer() : super.scoped() {
    registerFactory((container) => DashboardController(
          symptomPromptContainer("symptom/sleep"),
          symptomPromptContainer("symptom/sleepiness"),
          symptomPromptContainer("symptom/irritability"),
          symptomPromptContainer("symptom/anxiety"),
        ));
    registerFactory<WidgetBuilder>((container) => (BuildContext context) {
          final bloc = moodTrackerContainer<MoodTrackerBloc>();
          return Dashboard(
              // viewModel: dashboardContainer<DashboardController>().viewModel,
              // moodPickerBuilder: (context) => MoodPicker(
              //   events: bloc,
              //   state: bloc.stream,
              // ),
              // sleepPromptBuilder: symptomPromptContainer(),
              // irritabilityPromptBuilder: symptomPromptContainer(),
              // sleepinessPromptBuilder: symptomPromptContainer(),
              // anxietyPromptBuilder: symptomPromptContainer(),
              );
        });
  }
}

class BeckTestButtonContainer extends KiwiContainer {
  BeckTestButtonContainer() : super.scoped() {
    registerFactory((container) => const Clock());
    registerFactory((container) =>
        ObserveIfTestWasFilledToday(container(), beckTestDomainContainer()));
    registerFactory<TypedWidgetBuilder<BeckTestButton>>((container) =>
        (context) => BeckTestButton(
            isTestFilledToday: container<ObserveIfTestWasFilledToday>()()));
  }
}

class BeckCalendarContainer extends KiwiContainer {
  BeckCalendarContainer() : super.scoped() {
    registerFactory(
        (container) => BeckCalendarController(beckTestDomainContainer()));
    registerFactory<TypedWidgetBuilder<BeckCalendarView>>(
        (container) => (context) => BeckCalendarView(
              viewModel: container<BeckCalendarController>().viewModel,
            ));
  }
}

class MoodTrackerContainer extends KiwiContainer {
  MoodTrackerContainer() : super.scoped() {
    registerFactory((container) => const Clock());
    registerFactory<MoodLogRepository>(
        (container) => InMemoryMoodLogRepository(container()));
    registerFactory((container) => LogMood(container(), container()));
    registerFactory((container) => MoodTrackerBloc(container()));
  }
}

class HiveContainer extends KiwiContainer {
  HiveContainer() : super.scoped() {
    registerSingleton((container) => HiveLoader(
        symptomLogAdapter: container(), beckTestResultAdapter: container()));
    registerSingleton((container) => container<HiveLoader>().irritabilityBox,
        name: "symptom/irritability");
    registerSingleton((container) => container<HiveLoader>().sleepBox,
        name: "symptom/sleep");
    registerSingleton((container) => container<HiveLoader>().sleepinessBox,
        name: "symptom/sleepiness");
    registerSingleton((container) => container<HiveLoader>().anxietyBox,
        name: "symptom/anxiety");
    registerSingleton((container) => container<HiveLoader>().beckTestResultBox);
    registerSingleton<Loader>((container) => container<HiveLoader>());
    registerFactory((container) => SymptomLogAdapter());
    registerFactory((container) => BeckTestResultAdapter());
  }
}

class SymptomPromptContainer extends KiwiContainer {
  SymptomPromptContainer() : super.scoped() {
    registerFactory((container) => const Clock());
    for (final dependencyName in const [
      "symptom/sleep",
      "symptom/irritability",
      "symptom/sleepiness",
      "symptom/anxiety"
    ]) {
      registerFactory<SymptomRepository>(
          (container) => HiveSymptomRepository(hiveContainer(dependencyName)),
          name: dependencyName);
      registerFactory(
          (container) => LogSymptom(container(dependencyName), container()),
          name: dependencyName);
      registerFactory(
          (container) => ObserveSymptomHasValueToday(
              container(dependencyName), container()),
          name: dependencyName);
    }

    // registerFactory<SleepPromptBuilder>((container) => (context) => SleepPrompt(
    //       onSubmitted: container<LogSymptom>("symptom/sleep"),
    //     ));
    // registerFactory<IrritabilityPromptBuilder>(
    //     (container) => (context) => IrritabilityPrompt(
    //           onSubmitted: container<LogSymptom>("symptom/irritability"),
    //         ));
    // registerFactory<AnxietyPromptBuilder>(
    //     (container) => (context) => AnxietyPrompt(
    //           onSubmitted: container<LogSymptom>("symptom/anxiety"),
    //         ));
    // registerFactory<SleepinessPromptBuilder>(
    //     (container) => (context) => SleepinessPrompt(
    //           onSubmitted: container<LogSymptom>("symptom/sleepiness"),
    //         ));

    registerFactory<WidgetBuilder>(
        (container) => (context) => const IrritabilityPage(),
        name: "irritability_page");
  }
}

class SymptomsChartContainer extends KiwiContainer {
  SymptomsChartContainer() : super.scoped() {
    for (final symptom in const [
      "symptom/sleepiness",
      "symptom/anxiety",
      "symptom/irritability"
    ]) {
      registerFactory<SymptomLogRepository>(
          (container) => HiveSymptomRepository(hiveContainer(symptom)),
          name: symptom);
    }

    registerFactory<symptoms_chart.BeckTestResultRepository>(
        (container) => HiveBeckTestResultRepository(hiveContainer()));
    registerFactory((container) => SymptomsChartController(
        container("symptom/sleepiness"),
        container("symptom/anxiety"),
        container("symptom/irritability"),
        container()));
    registerFactory<TypedWidgetBuilder<SymptomsChart>>((container) =>
        (context) =>
            SymptomsChart(state: container<SymptomsChartController>().state));
  }
}

class JournalPageContainer extends KiwiContainer {
  JournalPageContainer(
      {required SymptomsChartContainer symptomsChartContainer,
      required BeckCalendarContainer beckCalendarContainer,
      required BeckTestButtonContainer beckTestButtonContainer})
      : super.scoped() {
    registerFactory<WidgetBuilder>(
        (container) => (BuildContext context) => JournalPage(
              symptomsChartBuilder: symptomsChartContainer(),
              calendarBuilder: beckCalendarContainer(),
              beckTestButtonBuilder: beckTestButtonContainer(),
            ));
  }
}

final beckTestResultContainer = BeckTestResultContainer();
final beckTestDomainContainer = BeckTestDomainContainer();
final dashboardContainer = DashboardContainer();
final beckCalendarContainer = BeckCalendarContainer();
final moodTrackerContainer = MoodTrackerContainer();
final symptomPromptContainer = SymptomPromptContainer();
final hiveContainer = HiveContainer();
final beckTestButtonContainer = BeckTestButtonContainer();
final symptomsChartContainer = SymptomsChartContainer();

class RouterContainer extends KiwiContainer {
  RouterContainer(
      BeckTestQuestionnaireContainer Function(BuildContext context)
          beckTestQuestionnaireContainer,
      DashboardContainer dashboardContainer,
      JournalPageContainer journalPageContainer)
      : super.scoped() {
    registerSingleton(
        (container) => GlobalKey<NavigatorState>(debugLabel: "root"),
        name: "root");
    registerSingleton(
        (container) => GlobalKey<NavigatorState>(debugLabel: "shell"),
        name: "shell");

    registerFactory<BeckTestResultPageBuilder>(
        (container) => (context, idParameter) {
              final id = InMemoryBeckTestId.deserialize(idParameter);
              return BeckTestResultPage(
                  getBeckTestResult: beckTestResultContainer(), id: id);
            });

    registerSingleton<ScaffoldBuilder>(
        (container) => (context, child) => Scaffold(
              body: child,
              extendBody: true,
              bottomNavigationBar: const BottomBar(),
            ));
    registerFactory<RouterConfig<Object>>((container) => AppRouter(
        irritabilityPageBuilder: symptomPromptContainer("irritability_page"),
        rootNavigatorKey: container("root"),
        shellNavigatorKey: container("shell"),
        scaffoldBuilder: container(),
        dashboardBuilder: dashboardContainer(),
        journalBuilder: journalPageContainer(),
        beckTestBuilder: (context) =>
            beckTestQuestionnaireContainer(context)<WidgetBuilder>()(context),
        beckTestResultBuilder: container()));
  }
}
