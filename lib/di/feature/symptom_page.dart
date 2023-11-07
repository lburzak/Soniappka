import 'package:easy_beck/di/common.dart';
import 'package:easy_beck/di/hive.dart';
import 'package:easy_beck/feature/symptom_page/service/symptom_page_controller.dart';
import 'package:easy_beck/feature/symptom_page/ui/anxiety_page.dart';
import 'package:easy_beck/feature/symptom_page/ui/irritability_page.dart';
import 'package:flutter/widgets.dart';

class InjectedIrritabilityPage extends StatefulWidget {

  const InjectedIrritabilityPage({super.key});

  @override
  State<InjectedIrritabilityPage> createState() => _InjectedIrritabilityPageState();
}

class _InjectedIrritabilityPageState extends State<InjectedIrritabilityPage> {
  late final viewModel = SymptomPageController(
      hiveDependencyGraph.irritabilityRepository, commonDependencyGraph.clock);

  @override
  Widget build(BuildContext context) {
    return IrritabilityPage(viewModel: viewModel);
  }
}

class InjectedAnxietyPage extends StatefulWidget {

  const InjectedAnxietyPage({super.key});

  @override
  State<InjectedAnxietyPage> createState() => _InjectedAnxietyPageState();
}

class _InjectedAnxietyPageState extends State<InjectedAnxietyPage> {
  late final viewModel = SymptomPageController(
      hiveDependencyGraph.anxietyRepository, commonDependencyGraph.clock);

  @override
  Widget build(BuildContext context) {
    return AnxietyPage(viewModel: viewModel);
  }
}

class InjectedSleepinessPage extends StatefulWidget {

  const InjectedSleepinessPage({super.key});

  @override
  State<InjectedSleepinessPage> createState() => _InjectedSleepinessPageState();
}

class _InjectedSleepinessPageState extends State<InjectedSleepinessPage> {
  late final viewModel = SymptomPageController(
      hiveDependencyGraph.sleepinessRepository, commonDependencyGraph.clock);

  @override
  Widget build(BuildContext context) {
    return AnxietyPage(viewModel: viewModel);
  }
}
