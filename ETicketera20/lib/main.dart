import 'package:eticketera20/providers/providers.dart';
import 'package:eticketera20/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(  
    url: 'https://tfkehsntemsntsdikaoh.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRma2Voc250ZW1zbnRzZGlrYW9oIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTk0NTMxMzcsImV4cCI6MjAzNTAyOTEzN30.TPDTPn_u0cG1yPCaVoEPtMWH3uyecikPXXlCFZmVPVQ',
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}
  class MyApp extends StatelessWidget {
    
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: themeNotifier.currentTheme,
          home: const HomeScreen(),
        );
      },
    );
  }
}