import 'package:eticketera20/providers/providers.dart';
import 'package:eticketera20/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeNotifier>(context).currentTheme.appBarTheme.backgroundColor,
        title: const Text('Politicas de privacidad'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            // Redirigir a HomeScreen
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
            itemBuilder: (BuildContext context) {
              bool isDarkTheme = Provider.of<ThemeNotifier>(context, listen: false).isDarkTheme;
              return <PopupMenuEntry<int>>[
                PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('Cambiar tema '),
                      Icon(isDarkTheme ? Icons.wb_sunny : Icons.nights_stay),
                    ],
                  ),
                ),
              const PopupMenuItem<int>(
                value: 2,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Notificaciones '),
                      Icon(Icons.notifications),
                    ],
                  ),
              ),
              const PopupMenuItem<int>(
                value: 3,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Políticas de privacidad '),
                      Icon(Icons.policy),
                    ],
                  ),
              ),
              const PopupMenuItem<int>(
                value: 4,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Contactos '),
                      Icon(Icons.contact_phone),
                    ],
                  ),
              ),
              const PopupMenuItem<int>(
                value: 5,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Editar perfil '),
                      Icon(Icons.person),
                    ],
                  ),
              ),
              const PopupMenuItem<int>(
                value: 6,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Cerrar sesión '),
                      Icon(Icons.logout, color: Colors.red),
                    ],
                  ),
              ),
            ];
            },
          ),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Políticas de Privacidad',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Esta es la política de privacidad de nuestra APP. Aquí describimos cómo manejamos los datos de los usuarios.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '1. Recopilación de Datos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Recopilamos la información que nos proporcionas cuando creas una cuenta, editas tu perfil o envías tickets de reclamo.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '2. Uso de Datos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Usamos tus datos para mejorar nuestra APP y proporcionar un mejor servicio. Esto incluye enviar notificaciones push y almacenar tu historial de tickets.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '3. Compartición de Datos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'No compartimos tus datos personales con terceros sin tu consentimiento, excepto cuando es necesario para cumplir con la ley.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '4. Seguridad de Datos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Tomamos medidas para proteger tus datos personales y asegurar que estén seguros.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '5. Tus Derechos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Tienes derecho a acceder, corregir y eliminar tus datos personales en cualquier momento.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
  void _menuAction(BuildContext context, int action) {
    switch (action) {
      case 1:
        Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
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
