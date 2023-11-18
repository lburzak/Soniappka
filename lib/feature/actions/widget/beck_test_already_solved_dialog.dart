import 'package:easy_beck/l10n/localizations.dart';
import 'package:easy_beck/common/ui/theme/theme_getter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BeckTestAlreadySolvedDialog extends StatelessWidget {
  final void Function() onProceed;

  const BeckTestAlreadySolvedDialog({super.key, required this.onProceed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.l10n.repeatTodayTestTitle,
        style: context.theme.textTheme.headlineLarge,
      ),
      content: Text(context.l10n.repeatTodayTestPrompt),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: context.theme.textTheme.labelLarge,
          ),
          onPressed: () {
            context.pop();
          },
          child: Text(context.l10n.decline),
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: context.theme.textTheme.labelLarge,
          ),
          onPressed: () {
            onProceed();
            context.pop();
          },
          child: Text(context.l10n.accept),
        ),
      ],
    );
  }
}
