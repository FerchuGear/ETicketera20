import 'package:eticketera20/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:pluto_menu_bar/pluto_menu_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Home'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            // Redirigir a HomeScreen (mismo pantalla)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert),
            onSelected: (int result) {
              _menuAction(context, result);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Cambiar tema'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Notificaciones'),
              ),
              const PopupMenuItem<int>(
                value: 3,
                child: Text('Políticas de privacidad'),
              ),
              const PopupMenuItem<int>(
                value: 4,
                child: Text('Contacto'),
              ),
              const PopupMenuItem<int>(
                value: 5,
                child: Text('Editar perfil'),
              ),
              const PopupMenuItem<int>(
                value: 6,
                child: Text('Cerrar sesión'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlassContainer(
              blur: 5,
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Tickets',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RequestScreen()),
                );
              },
              child: const Text('Enviar request'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RequestHistoryScreen()),
                );
              },
              child: const Text('Request enviados'),
            ),
          ],
        ),
      ),
    );
  }
  void _menuAction(BuildContext context, int action) {
    switch (action) {
      case 1:
        // Alternar el tema
        MyApp.themeNotifier.value = MyApp.themeNotifier.value == AppTheme.darkTheme
            ? ThemeData.light()
            : AppTheme.darkTheme;
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PrivacyScreen()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ContactScreen()),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EditProfileScreen()),
        );
        break;
      case 6:
        _logOut(context);
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You selected Item $action')),
        );
        break;
    }
  }

  Future<void> _logOut(BuildContext context) async {
    final supabase = Supabase.instance.client;
    await supabase.auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LogInScreen()),
      (Route<dynamic> route) => false,
    );
  }
}

