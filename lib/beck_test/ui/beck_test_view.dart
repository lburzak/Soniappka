import 'package:easy_beck/beck_test/ui/questionnaire_view.dart';
import 'package:easy_beck/beck_test/model/state.dart';
import 'package:flutter/material.dart';

class BeckTestView extends StatelessWidget {
  final Stream<BeckTestState> state;
  final void Function(int questionIndex, int answerIndex) onAnswerSelected;
  final void Function() onSubmit;

  const BeckTestView(
      {super.key,
      required this.state,
      required this.onAnswerSelected,
      required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD2E6C3),
      floatingActionButton: StreamBuilder(
        stream: state.map((event) => event is Solving && event.canSubmit),
        builder: (context, snapshot) => Visibility(
          visible: snapshot.data ?? false,
          child: FloatingActionButton(
            onPressed: onSubmit,
            child: const Icon(Icons.done),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: StreamBuilder(
          stream: state,
          builder: (context, snapshot) {
            final currentState = snapshot.data;

            return switch (currentState) {
              Finished() => Text("done"),
              Solving() => QuestionnaireView(
                  answers: currentState.answers,
                  options: currentState.options,
                  onAnswerSelected: onAnswerSelected,
                ),
              Loading() || null => SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}
