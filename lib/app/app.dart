import 'package:easy_beck/common/loader/loader.dart';
import 'package:easy_beck/common/loader/widget/loader_builder.dart';
import 'package:easy_beck/common/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  final RouterConfig<Object> routerConfig;
  final Loader loader;

  const App(
      {super.key,
      required this.routerConfig,
      required this.loader});

  @override
  Widget build(BuildContext context) {
    return LoaderBuilder(
        onReady: () {
          FlutterNativeSplash.remove();
        },
        loader: loader,
        builder: (context) => MaterialApp.router(
            title: "Soniappka",
            routerConfig: routerConfig,
            supportedLocales: const [Locale("pl")],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            theme: themeData));
  }
}
