import 'package:easy_beck/beck_test/model/beck_test_id.dart';
import 'package:easy_beck/beck_test/ui/result_view.dart';
import 'package:easy_beck/beck_test/usecase/get_beck_test_result.dart';
import 'package:easy_beck/common/ui/safe_future_builder.dart';
import 'package:flutter/material.dart';

class BeckTestResultPage extends StatelessWidget {
  final GetBeckTestResult getBeckTestResult;
  final BeckTestId id;

  const BeckTestResultPage(
      {super.key, required this.getBeckTestResult, required this.id});

  @override
  Widget build(BuildContext context) {
    return SafeFutureBuilder(
        future: getBeckTestResult.invoke(id),
        builder: (context, snapshot) => switch (snapshot) {
              DataAsyncSnapshot(data: final data) => data != null
                  ? ResultView(
                      points: data.points,
                      depressionLevel: data.depressionLevel)
                  : const SizedBox.shrink(),
              _ => const SizedBox.shrink()
            });
  }
}
