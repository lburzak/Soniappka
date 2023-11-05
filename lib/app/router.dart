import 'dart:async';

import 'package:easy_beck/app/app_router.dart';
import 'package:easy_beck/feature/beck_test/data/hive_beck_test_result_repository.dart';
import 'package:easy_beck/feature/beck_test/data/json_file_beck_repository.dart';
import 'package:easy_beck/feature/beck_test/repository/beck_test_result_repository.dart'
    as beck_test;
import 'package:easy_beck/common/loader.dart';
import 'package:easy_beck/feature/actions/data/default_day_phase_clock.dart';
import 'package:easy_beck/feature/actions/data/in_memory_action_completion_repository.dart';
import 'package:easy_beck/feature/actions/repository/action_completion_repository.dart';
import 'package:easy_beck/feature/actions/usecase/calendar.dart';
import 'package:easy_beck/feature/actions/usecase/get_task_status.dart';
import 'package:easy_beck/feature/actions/usecase/toggle_task.dart';
import 'package:easy_beck/feature/actions/usecase/watch_beck_test_task.dart';
import 'package:easy_beck/feature/actions/usecase/watch_tasks.dart';
import 'package:easy_beck/feature/dashboard/check_beck_test_solved.dart';
import 'package:easy_beck/feature/dashboard/dashboard_event.dart';
import 'package:easy_beck/feature/dashboard/material_dashboard_router.dart';
import 'package:easy_beck/feature/dashboard/new_dashboard_controller.dart';
import 'package:easy_beck/feature/symptom_page/anxiety_page.dart';
import 'package:easy_beck/feature/symptom_page/irritability_page.dart';
import 'package:easy_beck/feature/symptom_page/sleepiness_page.dart';
import 'package:easy_beck/feature/symptom_page/symptom_page_controller.dart';
import 'package:easy_beck/feature/symptom_page/symptom_page_view_model.dart';
import 'package:easy_beck/feature/symptoms_chart/domain/beck_test_result_repository.dart'
    as symptoms_chart;
import 'package:easy_beck/feature/beck_test/repository/depression_level_repository.dart';
import 'package:easy_beck/feature/beck_test/repository/question_repository.dart';
import 'package:easy_beck/feature/beck_test/service/beck_test_controller.dart';
import 'package:easy_beck/feature/beck_test/service/beck_test_router.dart';
import 'package:easy_beck/feature/beck_test/ui/beck_test_result_page.dart';
import 'package:easy_beck/feature/beck_test/ui/beck_test_view.dart';
import 'package:easy_beck/feature/beck_test/usecase/get_beck_test_result.dart';
import 'package:easy_beck/feature/beck_test/usecase/submit_beck_test.dart';
import 'package:easy_beck/common/ui/typed_widget_builder.dart';
import 'package:easy_beck/feature/dashboard/dashboard.dart';
import 'package:easy_beck/feature/symptom_prompt/data/hive_symptom_repository.dart';
import 'package:easy_beck/feature/symptom_prompt/domain/log_symptom.dart';
import 'package:easy_beck/feature/symptom_prompt/domain/observe_symptom_has_value_today.dart';
import 'package:easy_beck/feature/symptom_prompt/domain/symptom_repository.dart';
import 'package:easy_beck/feature/symptoms_chart/domain/symptom_log_repository.dart';
import 'package:easy_beck/feature/symptoms_chart/service/symptoms_chart_controller.dart';
import 'package:easy_beck/feature/symptoms_chart/ui/symptoms_chart.dart';
import 'package:easy_beck/hive/adapter/beck_test_result_adapter.dart';
import 'package:easy_beck/hive/adapter/symptom_log_adapter.dart';
import 'package:easy_beck/hive/hive_loader.dart';
import 'package:easy_beck/isar/isar_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stream_listener/flutter_stream_listener.dart';
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
  DashboardContainer(IsarContainer isarContainer) : super.scoped() {
    registerSingleton<ActionCompletionRepository>(
        (container) => InMemoryActionCompletionRepository());
    registerFactory((container) => GetTaskStatus(
        actionCompletionRepository: container(),
        clock: const Clock(),
        calendar: JiffyCalendar(),
        dayPhaseClock: DefaultDayPhaseClock()));
    registerFactory((container) => WatchTasks(
        actionRepository: isarContainer(),
        getTaskStatus: container(),
        actionCompletionRepository: container()));
    registerFactory((container) => ToggleTask(
        actionCompletionRepository: container(), clock: const Clock()));
    registerFactory((container) => WatchBeckTestTask(
        beckTestResultRepository: beckTestDomainContainer(),
        calendar: JiffyCalendar(),
        clock: const Clock()));
    registerSingleton(
        (container) => StreamController<DashboardEvent>.broadcast());
    registerFactory<EventSink<DashboardEvent>>(
        (container) => container<StreamController<DashboardEvent>>().sink);
    registerFactory<Stream<DashboardEvent>>(
        (container) => container<StreamController<DashboardEvent>>().stream);
    registerFactory<WidgetBuilder>((container) {
      return (BuildContext context) {
        final controller = NewDashboardController(
            sleepinessRepository: symptomPromptContainer("symptom/sleepiness"),
            irritabilityRepository:
                symptomPromptContainer("symptom/irritability"),
            anxietyRepository: symptomPromptContainer("symptom/anxiety"),
            toggleTask: container(),
            watchBeckTestTask: container(),
            clock: const Clock(),
            router: MaterialDashboardRouter(context: context),
            checkBeckTestSolved: CheckBeckTestStatusForDay(
                beckTestResultRepository: beckTestDomainContainer()));

        return StreamListener<DashboardEvent>(
            stream: container<Stream<DashboardEvent>>(),
            onData: controller.handleEvent,
            child: Dashboard(
                state: controller
                    .createState()
                    .asBroadcastStream(),
                sink: container<EventSink<DashboardEvent>>()));
      };
    });
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

    registerFactory<SymptomPageViewModel>(
        (container) => SymptomPageController(
            container("symptom/irritability"), const Clock()),
        name: "symptom/irritability");

    registerFactory<SymptomPageViewModel>(
        (container) => SymptomPageController(
            container("symptom/sleepiness"), const Clock()),
        name: "symptom/sleepiness");

    registerFactory<SymptomPageViewModel>(
        (container) =>
            SymptomPageController(container("symptom/anxiety"), const Clock()),
        name: "symptom/anxiety");

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

    // TODO: Try to parametrize containers
    registerFactory<WidgetBuilder>(
        (container) => (context) => IrritabilityPage(
              viewModel: container("symptom/irritability"),
            ),
        name: "irritability_page");

    registerFactory<WidgetBuilder>(
        (container) => (context) => SleepinessPage(
              viewModel: container("symptom/sleepiness"),
            ),
        name: "sleepiness_page");

    registerFactory<WidgetBuilder>(
        (container) => (context) => AnxietyPage(
              viewModel: container("symptom/anxiety"),
            ),
        name: "anxiety_page");
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

final beckTestResultContainer = BeckTestResultContainer();
final beckTestDomainContainer = BeckTestDomainContainer();
final symptomPromptContainer = SymptomPromptContainer();
final hiveContainer = HiveContainer();
final symptomsChartContainer = SymptomsChartContainer();

class RouterContainer extends KiwiContainer {
  RouterContainer(
      BeckTestQuestionnaireContainer Function(BuildContext context)
          beckTestQuestionnaireContainer,
      DashboardContainer dashboardContainer)
      : super.scoped() {
    registerSingleton(
        (container) => GlobalKey<NavigatorState>(debugLabel: "root"),
        name: "root");
    registerSingleton(
        (container) => GlobalKey<NavigatorState>(debugLabel: "shell"),
        name: "shell");

    registerFactory<BeckTestResultPageBuilder>(
        (container) => (context, idParameter) {
              final id = DateTimeBeckTestId.fromDayHashCode(int.parse(idParameter));
              return BeckTestResultPage(
                  getBeckTestResult: beckTestResultContainer(), id: id);
            });

    registerSingleton<ScaffoldBuilder>(
        (container) => (context, child) => Scaffold(body: child));
    registerFactory<RouterConfig<Object>>((container) => AppRouter(
        irritabilityPageBuilder: symptomPromptContainer("irritability_page"),
        sleepinessPageBuilder: symptomPromptContainer("sleepiness_page"),
        anxietyPageBuilder: symptomPromptContainer("anxiety_page"),
        rootNavigatorKey: container("root"),
        shellNavigatorKey: container("shell"),
        scaffoldBuilder: container(),
        dashboardBuilder: dashboardContainer(),
        beckTestBuilder: (context) =>
            beckTestQuestionnaireContainer(context)<WidgetBuilder>()(context),
        beckTestResultBuilder: container()));
  }
}
