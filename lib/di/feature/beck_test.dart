import 'package:easy_beck/di/domain.dart';
import 'package:easy_beck/di/json.dart';
import 'package:easy_beck/feature/beck_test/service/beck_test_controller.dart';
import 'package:easy_beck/feature/beck_test/service/beck_test_router.dart';
import 'package:easy_beck/feature/beck_test/ui/beck_test_result_page.dart';
import 'package:easy_beck/feature/beck_test/ui/beck_test_view.dart';
import 'package:easy_beck/hive/beck_test_result/date_time_beck_test_id.dart';
import 'package:flutter/material.dart';

class InjectedBeckTest extends StatefulWidget {
  const InjectedBeckTest({super.key});

  @override
  State<InjectedBeckTest> createState() => _InjectedBeckTestState();
}

class _InjectedBeckTestState extends State<InjectedBeckTest> {
  late final router = GoBeckTestRouter(context);

  late final controller = BeckTestController(
      jsonDependencyContext.jsonFileBeckRepository,
      domainDependencyGraph.submitBeckTest,
      router);

  @override
  Widget build(BuildContext context) {
    return BeckTestView(
        state: controller.state,
        onAnswerSelected: controller.selectAnswer,
        onSubmit: controller.submit);
  }
}

class InjectedBeckTestResultPage extends StatelessWidget {
  final String idParameter;

  const InjectedBeckTestResultPage({super.key, required this.idParameter});

  @override
  Widget build(BuildContext context) {
    return BeckTestResultPage(
        getBeckTestResult: domainDependencyGraph.getBeckTestResult,
        id: DateTimeBeckTestId.fromDayHashCode(int.parse(idParameter)));
  }
}
