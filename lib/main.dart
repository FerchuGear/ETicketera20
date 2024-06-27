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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      darkTheme: AppTheme.darkTheme,
      home: const LogInScreen(),
      );
  }
}