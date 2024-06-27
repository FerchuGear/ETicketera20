import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:eticketera20/screens/screens.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  String _errorMessage = '';
  String _successMessage = '';

  Future<void> _sendPasswordResetEmail() async {
    final email = _emailController.text;

    final supabase = Supabase.instance.client;
    try {
      await supabase.auth.resetPasswordForEmail(email);
      setState(() {
        _successMessage = 'Se ha enviado un enlace de recuperación a su correo electrónico.';
        _errorMessage = '';
      });
    } catch (error) {
      setState(() {
        _errorMessage = _extractErrorMessage(error);
        _successMessage = '';
      });
    }
  }

  String _extractErrorMessage(Object error) {
    if (error is AuthException) {
      return error.message;
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
            const Text(
              'Recuperación de Contraseña',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Correo Electrónico'),
            ),
            const SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            if (_successMessage.isNotEmpty)
              Text(
                _successMessage,
                style: const TextStyle(color: Colors.green),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _sendPasswordResetEmail();
              },
              child: const Text('Enviar Enlace de Recuperación'),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Navegar a la LogInScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogInScreen()),
                );
              },
              child: const Text(
                '¿Recordaste tu contraseña? ¡Inicia sesión!',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}