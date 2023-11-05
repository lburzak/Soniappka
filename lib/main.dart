import 'package:easy_beck/app/router.dart';
import 'package:easy_beck/common/loader.dart';
import 'package:easy_beck/common/multi_loader.dart';
import 'package:easy_beck/common/ui/loader_builder.dart';
import 'package:easy_beck/isar/isar_container.dart';
import 'package:easy_beck/theme/backgrounds.dart';
import 'package:easy_beck/theme/borders.dart';
import 'package:easy_beck/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Intl.defaultLocale = "pl_PL";
  final isarContainer = IsarContainer();
  final routerContainer = RouterContainer(
      (context) => BeckTestQuestionnaireContainer(context),
      DashboardContainer(isarContainer),
      JournalPageContainer(symptomsChartContainer: SymptomsChartContainer()));

  runApp(MyApp(
    routerConfig: routerContainer(),
    loader: MultiLoader(loaders: [hiveContainer(), isarContainer()]),
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
        onReady: () {
          FlutterNativeSplash.remove();
        },
        loader: loader,
        builder: (context) => MaterialApp.router(
            title: "Soniappka",
            routerConfig: routerConfig,
            supportedLocales: const [Locale("pl")],
            locale: const Locale("pl"),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                extensions: [
                  const Backgrounds(selected: Colors.white24),
                  Borders(
                      thin: Border.all(width: 0.5),
                      regular: Border.all(width: 1)),
                  const ExtraColors(modalBarrier: Colors.black38)
                ],
                colorScheme: ColorScheme.fromSeed(
                    seedColor: Color(0xffA0C49D),
                    background: const Color(0xffC4D7B2)),
                cardTheme: const CardTheme(
                    surfaceTintColor: Color(0xffF4F2DE),
                    color: Color(0xffF7FFE5)),
                // iconTheme: const IconThemeData(color: Color(0xffA0C49D)),
                useMaterial3: true,
                textTheme: font.copyWith(
                    displayLarge: font.displayLarge?.copyWith(fontSize: 64),
                    headlineLarge: GoogleFonts.amaticSc()
                        .copyWith(fontSize: 32, fontWeight: FontWeight.bold),
                    headlineSmall: font.headlineSmall
                        ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                    titleMedium: font.titleMedium?.copyWith(fontSize: 20),
                    labelLarge: font.labelLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )))));
  }
}
