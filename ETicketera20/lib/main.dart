import 'package:eticketera20/providers/theme_notifier.dart';
import 'package:eticketera20/screens/home_screen.dart';
import 'package:eticketera20/screens/login_screen.dart';
import 'package:eticketera20/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://tfkehsntemsntsdikaoh.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRma2Voc250ZW1zbnRzZGlrYW9oIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTk0NTMxMzcsImV4cCI6MjAzNTAyOTEzN30.TPDTPn_u0cG1yPCaVoEPtMWH3uyecikPXXlCFZmVPVQ',
  );
  runApp(const MyApp());
}
// ValueNotifier para manejar el tema
  final ValueNotifier<ThemeData> themeNotifier = ValueNotifier<ThemeData>(AppTheme.darkTheme);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeNotifier,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          theme: themeNotifier.value,
          home: const HomeScreen(),
        );
      },
    );
  }
}