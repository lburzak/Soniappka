import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BeckTestButton extends StatelessWidget {
  final Stream<bool> isTestFilledToday;

  const BeckTestButton({super.key, required this.isTestFilledToday});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: isTestFilledToday,
        builder: (context, isTodayTestFilled) => ElevatedButton.icon(
              onPressed: () {
                context.push("/beck-test");
              },
              icon: const Icon(Icons.assignment),
              label: Text(isTodayTestFilled.data == true
                  ? "Powtórz dzisiejszy test"
                  : "Wykonaj test"),
            ));
  }
}
