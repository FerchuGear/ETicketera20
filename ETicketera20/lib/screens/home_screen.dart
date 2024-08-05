import 'package:eticketera20/providers/providers.dart';
import 'package:eticketera20/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Provider.of<ThemeNotifier>(context).currentTheme;
    // Porcentaje del ancho y alto del GlassContainer 
    double containerWidthPercentage = 0.8;
    double containerHeightPercentage = 0.3;
    return Scaffold(
      //Estilo de la AppBar
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeNotifier>(context).currentTheme.appBarTheme.backgroundColor,
        title: const Text('Home'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            FractionallySizedBox(
              child: GlassContainer(
                width: MediaQuery.of(context).size.width * containerWidthPercentage,
                height: MediaQuery.of(context).size.height * containerHeightPercentage,
                blur: 6,
                color: currentTheme.primaryColor.withOpacity(0.4), 
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: currentTheme.primaryColor.withOpacity(0.4), width: 1.5),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tickets restantes:',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),
                    ),
                    Text(
                      '3/3',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ] 
                ),
              ),
            ),
            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OrderScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                maximumSize: Size(MediaQuery.of(context).size.width * 0.6, 50),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.6, 50),
                backgroundColor: currentTheme.primaryColor,
              ),
              label: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Pedir notebooks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Icon(Icons.computer_rounded),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RequestScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                maximumSize: Size(MediaQuery.of(context).size.width * 0.6, 50),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.6, 50),
                backgroundColor: currentTheme.primaryColor,
              ),
              label: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Notificar fallos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Icon(Icons.error_rounded),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RequestHistoryScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                maximumSize: Size(MediaQuery.of(context).size.width*0.6, 50),
                minimumSize: Size(MediaQuery.of(context).size.width*0.6, 50),
                backgroundColor: currentTheme.primaryColor,
              ),
              label: const Padding(
                padding: EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Request enviados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Icon(Icons.history_rounded)
                  ],
                )
              ),
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