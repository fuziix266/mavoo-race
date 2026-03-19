import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme/app_theme.dart';
import 'providers/race_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RaceProvider(),
      child: const MallkuBoxApp(),
    ),
  );
}

class MallkuBoxApp extends StatelessWidget {
  const MallkuBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MALLKUBOX Race 2026',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme.copyWith(
        textTheme: GoogleFonts.interTextTheme(AppTheme.theme.textTheme),
      ),
      home: const HomeScreen(),
    );
  }
}
