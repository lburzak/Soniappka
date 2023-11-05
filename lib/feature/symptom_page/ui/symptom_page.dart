import 'package:easy_beck/common/ui/widget/rating_selector.dart';
import 'package:easy_beck/feature/symptom_page/model/symptom_page_view_model.dart';
import 'package:easy_beck/common/ui/theme/colors.dart';
import 'package:easy_beck/common/ui/theme/theme_getter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SymptomPage extends StatelessWidget {
  final String title;
  final String description;
  final Widget image;
  final List<Rating> ratings;
  final SymptomPageViewModel viewModel;

  const SymptomPage(
      {super.key,
      required this.viewModel,
      required this.title,
      required this.description,
      required this.image,
      required this.ratings});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ModalBarrier(color: context.theme.colors.modalBarrier),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge),
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
                        style: context.theme.textTheme.headlineSmall,
                      ),
                      SizedBox(
                          height: 210,
                          child: StreamBuilder(
                              stream: viewModel.level,
                              builder: (context, snapshot) {
                                return RatingSelector(
                                  ratings: ratings,
                                  level: snapshot.data,
                                  onLevelSelected: (level) {
                                    if (level == null) {
                                      viewModel.unsetLevel();
                                    } else {
                                      viewModel.setLevel(level);
                                    }
                                  },
                                );
                              }))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
