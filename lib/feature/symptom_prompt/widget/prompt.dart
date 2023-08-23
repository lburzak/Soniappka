import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Prompt extends StatelessWidget {
  final String title;
  final Widget icon;
  final Widget body;
  final VoidCallback onSubmitted;
  final Color color;

  const Prompt(
      {super.key,
      required this.title,
      required this.icon,
      required this.body,
      required this.onSubmitted, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(title,
                    style: GoogleFonts.amaticSc()
                        .copyWith(fontSize: 32, fontWeight: FontWeight.bold))),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 28),
              child: icon,
            ),
            body,
            ElevatedButton.icon(
              onPressed: onSubmitted,
              icon: const Icon(Icons.done),
              label: const Text("Zatwierdź"),
              style: const ButtonStyle(
                  surfaceTintColor: MaterialStatePropertyAll(Colors.green)),
            )
          ],
        ),
      ),
    );
  }
}
