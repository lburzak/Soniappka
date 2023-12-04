import 'package:easy_beck/common/ui/theme/colors.dart';
import 'package:easy_beck/common/ui/theme/theme_getter.dart';
import 'package:easy_beck/domain/common/day.dart';
import 'package:easy_beck/l10n/localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:morphable_shape/morphable_shape.dart';

class Dashboard extends StatelessWidget {
  final Day day;
  final bool isToday;
  final List<Widget> symptomTiles;
  final Widget tasksGrid;
  final void Function() onGoToYesterday;
  final void Function() onGoToToday;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isToday
          ? context.theme.colorScheme.background
          : context.theme.colors.backgroundVariant,
      child: SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                  padding: EdgeInsets.zero,
                  sliver: SliverToBoxAdapter(
                    child: Stack(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Visibility(
                                visible: isToday,
                                child: GestureDetector(
                                    onTap: () => onGoToYesterday(),
                                    child: const _FoldedCornerPrevious()))),
                        Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Text(
                                  DateFormat.MMMMEEEEd().format(day.dateTime),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                            )),
                        Align(
                            alignment: Alignment.topRight,
                            child: switch (isToday) {
                              false => GestureDetector(
                                  onTap: () => onGoToToday(),
                                  child: const _FoldedCornerNext()),
                              _ => const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  child: _StatisticsButton(),
                                ),
                            }),
                      ],
                    ),
                  )),
              _Header(text: context.l10n.symptoms),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                sliver: SliverList.list(children: symptomTiles),
              ),
              _Header(text: context.l10n.therapy),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                sliver: tasksGrid,
              )
            ],
          )),
    );
  }

  const Dashboard({
    super.key,
    required this.day,
    required this.isToday,
    required this.symptomTiles,
    required this.tasksGrid,
    required this.onGoToYesterday,
    required this.onGoToToday,
  });
}

class _Header extends StatelessWidget {
  final String text;

  const _Header({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      sliver: SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  Text(text, style: Theme.of(context).textTheme.headlineLarge),
              childCount: 1),
          itemExtent: 40),
    );
  }
}

class _StatisticsButton extends StatelessWidget {
  const _StatisticsButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          context.push("/journal");
        },
        icon: const Icon(Icons.bar_chart));
  }
}

class _FoldedCornerNext extends StatelessWidget {
  const _FoldedCornerNext();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.colorScheme.background,
      elevation: 4,
      shape: TriangleShapeBorder(
        point3: DynamicOffset(
            _foldedCornerSize.toPXLength, _foldedCornerSize.toPXLength),
      ),
      clipBehavior: Clip.antiAlias,
      child: const SizedBox(
        width: _foldedCornerSize,
        height: _foldedCornerSize,
      ),
    );
  }
}

class _FoldedCornerPrevious extends StatelessWidget {
  const _FoldedCornerPrevious();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _foldedCornerSize,
      height: _foldedCornerSize,
      color: context.theme.colors.backgroundVariant,
      child: Material(
        color: context.theme.colors.backgroundDark,
        elevation: 4,
        shape: TriangleShapeBorder(
          point1: DynamicOffset(0.toPXLength, _foldedCornerSize.toPXLength),
          point3: DynamicOffset(
              _foldedCornerSize.toPXLength, _foldedCornerSize.toPXLength),
        ),
        clipBehavior: Clip.antiAlias,
        child: const SizedBox(
          width: _foldedCornerSize,
          height: _foldedCornerSize,
        ),
      ),
    );
  }
}

const _foldedCornerSize = 50.0;
