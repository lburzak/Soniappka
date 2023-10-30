import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class BeckTestAlreadySolvedDialog extends StatelessWidget {
  final void Function() onProceed;

  const BeckTestAlreadySolvedDialog({super.key, required this.onProceed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Powtórz dzisiejszy test', style: GoogleFonts.amaticSc().copyWith(
          fontSize: 32,
          fontWeight: FontWeight.bold),),
      content: const Text(
        'Kwestionariusz Becka został już dzisiaj przez Ciebie wypełniony. Czy chcesz go powtórzyć?',
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          onPressed: () {
            context.pop();
          },
          child: const Text('Nie'),
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          onPressed: () {
            onProceed();
            context.pop();
          },
          child: const Text('Tak'),
        ),
      ],
    );
  }

}
