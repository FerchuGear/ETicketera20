import 'package:flutter/material.dart';
import 'package:eticketera20/providers/providers.dart';
import 'package:eticketera20/screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Classroom {
  final int id;
  final String name;

  Classroom({required this.id, required this.name});

  factory Classroom.fromMap(Map<String, dynamic> map) {
    return Classroom(
      id: map['id'],
      name: map['classrooms'],
    );
  }
}

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  Future<List<Classroom>>? _classroomsFuture;
  String? selectedClassroom;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _classroomsFuture = _fetchClassrooms();
  }

  Future<List<Classroom>> _fetchClassrooms() async {
    try {
      final response = await supabase.from('Classrooms').select();
      return response.map((item) => Classroom.fromMap(item)).toList();
    } catch (error) {
      setState(() {
        _errorMessage = 'Error al obtener las aulas: $error';
      });
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    double containerWidthPercentage = 0.8;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeNotifier>(context).currentTheme.appBarTheme.backgroundColor,
        title: const Text('Notificar fallos'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
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
        child: FutureBuilder<List<Classroom>>(
          future: _classroomsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 30,),
                  Container(
                    width: MediaQuery.of(context).size.width * containerWidthPercentage,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Seleccione un aula',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        DropdownButton<String>(
                          value: selectedClassroom,
                          hint: const Text('Selecciona un aula'),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedClassroom = newValue;
                            });
                          },
                          items: snapshot.data!.map<DropdownMenuItem<String>>((Classroom classroom) {
                            return DropdownMenuItem<String>(
                              value: classroom.id.toString(),
                              child: Text(classroom.name),
                            );
                          }).toList(),
                        ),
                        if (snapshot.data == null || snapshot.data!.isEmpty)
                          const Text('No hay aulas disponibles'),
                      ],
                    ),
                  ),
                  
                ],
              );
            }
          },
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
