import 'package:easy_beck/common/ui/rating_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SymptomPage extends HookWidget {
  final String title;
  final String description;
  final Widget image;
  final List<Rating> ratings;
  final void Function(int level) onUpdated;

  const SymptomPage(
      {super.key,
      required this.title,
      required this.description,
      required this.image,
      required this.ratings,
      required this.onUpdated});

  @override
  Widget build(BuildContext context) {
    final currentLevel = useState(2);

    return Scaffold(
      body: SafeArea(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title,
                            style: GoogleFonts.amaticSc().copyWith(
                                fontSize: 32, fontWeight: FontWeight.bold)),
                        IconButton(
                            onPressed: () {
                              context.pop();
                            },
                            icon: const Icon(Icons.close))
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 28),
                  child: image,
                ),
                Text(
                  description,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                    height: 210,
                    child: RatingSelector(
                      ratings: ratings,
                      initialLevel: 2,
                      onLevelSelected: (level) {
                        currentLevel.value = level;
                        onUpdated(level);
                      },
                    )),
                Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
