import 'package:easy_beck/domain/beck_test/model/beck_test_id.dart';
import 'package:easy_beck/domain/beck_test/usecase/get_beck_test_result.dart';
import 'package:easy_beck/feature/beck_test/ui/result_view.dart';
import 'package:easy_beck/common/ui/widget/safe_future_builder.dart';
import 'package:easy_beck/l10n/localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BeckTestResultPage extends StatelessWidget {
  final GetBeckTestResult getBeckTestResult;
  final BeckTestId id;

  const BeckTestResultPage(
      {super.key, required this.getBeckTestResult, required this.id});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SafeFutureBuilder(
            future: getBeckTestResult.invoke(id),
            builder: (context, snapshot) => switch (snapshot) {
                  DataAsyncSnapshot(data: final data) => data != null
                      ? ResultView(
                          points: data.points,
                          depressionLevel: data.depressionLevel)
                      : const SizedBox.shrink(),
                  _ => const SizedBox.shrink()
                }),
        Positioned(
            bottom: 64,
            child: Wrap(
              spacing: 24,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      context.replace("/beck-test");
                    },
                    icon: const Icon(Icons.refresh),
                    label: Text(context.l10n.restart)),
                ElevatedButton.icon(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.done),
                    label: Text(context.l10n.finish))
              ],
            ))
      ],
    );
  }
}
