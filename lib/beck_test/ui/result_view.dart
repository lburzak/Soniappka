import 'package:easy_beck/beck_test/model/depression_level.dart';
import 'package:flutter/material.dart';

class ResultView extends StatelessWidget {
  final int points;
  final DepressionLevel depressionLevel;

  const ResultView(
      {super.key, required this.points, required this.depressionLevel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$points", style: const TextStyle(fontSize: 64),),
            Text(getDepressionLevelString(context),
                style: const TextStyle(fontSize: 22))
          ],
        ),
      ),
    );
  }

  String getDepressionLevelString(BuildContext context) {
    return switch (depressionLevel) {
      DepressionLevel.none => "Brak depresji",
      DepressionLevel.mild => "Łagodna depresja",
      DepressionLevel.moderate => "Umiarkowana depresja",
      DepressionLevel.severe => "Silna depresja"
    };
  }
}
