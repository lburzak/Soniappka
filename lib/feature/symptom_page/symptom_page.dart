import 'package:easy_beck/common/ui/rating_selector.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SymptomPage extends StatelessWidget {
  final String title;
  final String description;
  final Widget image;
  final List<Rating> ratings;
  final Stream<int?> level;
  final void Function(int? level) onUpdated;

  const SymptomPage(
      {super.key,
      required this.title,
      required this.description,
      required this.image,
      required this.ratings,
      required this.onUpdated,
      required this.level});

  @override
  Widget build(BuildContext context) {
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
                    child: StreamBuilder(
                      stream: level,
                      builder: (context, snapshot) {
                        return RatingSelector(
                          ratings: ratings,
                          level: snapshot.data,
                          onLevelSelected: (level) {
                            onUpdated(level);
                          },
                        );
                      }
                    )),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
