import 'package:easy_beck/beck_test/data/json_file_beck_repository.dart';
import 'package:easy_beck/beck_test/ui/beck_test_view.dart';
import 'package:easy_beck/beck_test/service/beck_test_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final repo = JsonFileBeckRepository();
  late final controller = BeckTestController(repo, repo);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: GoogleFonts.cormorantInfantTextTheme()),
      home: BeckTestView(
          state: controller.state,
          onSubmit: controller.submit,
          onAnswerSelected: controller.selectAnswer),
    );
  }
}
