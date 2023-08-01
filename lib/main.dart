import 'package:easy_beck/app/router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: router,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              background: const Color(0xffD2E6C3)),
          useMaterial3: true,
          textTheme: GoogleFonts.cormorantInfantTextTheme().copyWith(
            labelLarge: GoogleFonts.cormorantInfantTextTheme().labelLarge?.copyWith(fontSize: 16, fontWeight: FontWeight.bold, )
          )));
}
