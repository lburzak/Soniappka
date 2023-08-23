import 'package:easy_beck/app/router.dart';
import 'package:easy_beck/common/loader.dart';
import 'package:easy_beck/common/ui/loader_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  final routerContainer = RouterContainer(
      (context) => BeckTestQuestionnaireContainer(context),
      DashboardContainer(),
      JournalPageContainer(
          symptomsChartContainer: SymptomsChartContainer(),
          beckCalendarContainer: BeckCalendarContainer(),
          beckTestButtonContainer: BeckTestButtonContainer()));

  runApp(MyApp(
    routerConfig: routerContainer(),
    loader: hiveContainer(),
  ));
}

class MyApp extends StatelessWidget {
  final RouterConfig<Object> routerConfig;
  final Loader loader;

  const MyApp({super.key, required this.routerConfig, required this.loader});

  @override
  Widget build(BuildContext context) {
    final font = GoogleFonts.itimTextTheme();
    return LoaderBuilder(
        loader: loader,
        builder: (context) => MaterialApp.router(
            title: 'Flutter Demo',
            routerConfig: routerConfig,
            supportedLocales: const [Locale("pl")],
            locale: const Locale("pl"),
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.deepPurple,
                    background: const Color(0xffD2E6C3)),
                cardTheme: const CardTheme(surfaceTintColor: Colors.white),
                useMaterial3: true,
                textTheme: font.copyWith(
                    labelLarge: font.labelLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )))));
  }
}
