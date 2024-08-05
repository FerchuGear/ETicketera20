import 'package:eticketera20/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';
  bool _isPasswordVisible = false;

  Future<void> _logIn() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final supabase = Supabase.instance.client;
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      //final AuthResponse res = await supabase.auth.signInWithPassword(
        //email: 'usuario@gmail.com',
        //password: 'contraseña',
      //);
      final Session? session = res.session;
      final User? user = res.user;

      if (user != null) {

         final data = await supabase
          .from('Users')
          .select("*")
          .eq('uid', user.id );
      
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        setState(() {
          _errorMessage = 'Inicio de sesión fallido. Por favor, intente de nuevo.';
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = _extractErrorMessage(error);
        _passwordController.clear();
      });
    }
  }

  String _extractErrorMessage(Object error) {
    if (error is AuthException) {
      return (error.message == "Invalid login credentials") ? "Correo o contraseña incorrectas. Por favor, intente de nuevo." : error.message;
    } else {
      return 'Ocurrió un error inesperado';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Correo Electrónico'),
            ),
            const SizedBox(height: 20,),
            TextField(

              controller: _passwordController,
              decoration:  InputDecoration(labelText: 'Contraseña', suffixIcon: IconButton(onPressed: (){
                setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
              }, icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off,))),
              obscureText: !_isPasswordVisible,
            ),
            const SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _logIn();
              },
              child: const Text('Iniciar Sesión'),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Navegar a la RegisterScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
              child: const Text(
                '¿Aún no tienes una cuenta? ¡Regístrate!',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // Navegar a la ForgotPasswordScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                );
              },
              child: const Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
