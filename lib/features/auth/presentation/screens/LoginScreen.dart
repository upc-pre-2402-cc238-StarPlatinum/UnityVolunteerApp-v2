import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/models/LoginRequestModel.dart';
import '../../data/repositories/AuthRepository.dart';

import 'ScreenHomeOrganizacion.dart';
import 'ScreenHomeVoluntario.dart';
import 'RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final AuthRepository _authRepository = AuthRepository();
  bool _isLoading = false;

  // Login de usuario
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final loginModel = LoginModel(
        correo: _correoController.text,
        contrasena: _contrasenaController.text,
      );

      final response = await _authRepository.loginUser(loginModel);

      final String tipoUsuario = response['tipoUsuario'];
      final int usuarioId = response['usuarioId'];
      final String nombre = response['nombre'];

      // Redirigir según el tipo de usuario
      if (tipoUsuario == 'VOLUNTARIO') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>ScreenHomeVoluntario(usuarioId: usuarioId, nombre: nombre),
          ),
        );
      } else if (tipoUsuario == 'ORGANIZACION') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScreenHomeOrganizacion(usuarioId: usuarioId, nombre: nombre),
          ),
        );
      }
    } catch (e) {
      if (e.toString().contains('Correo o contraseña incorrectos')) {
        _showErrorDialog('Correo o contraseña incorrectos');
      } else {
        _showErrorDialog('Error en el inicio de sesión: $e');
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String mensaje) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(mensaje),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF3894B6),
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Logo
            Center(
              child: Image.asset('assets/images/logo.png', height: 100),
            ),
            const SizedBox(height: 40),

            // Email TextField
            TextField(
              controller: _correoController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                filled: true,
                fillColor: Color(0xFFF5F6FA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Password TextField
            TextField(
              controller: _contrasenaController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                filled: true,
                fillColor: Color(0xFFF5F6FA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),

            // Recordarme Checkbox
            Row(
              children: [
                Checkbox(value: false, onChanged: (bool? newValue) {}),
                Text('Recordarme', style: TextStyle(color: Colors.blue)),
              ],
            ),
            SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF6A00),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _isLoading ? null : _login,
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Log In', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                  },
                  child: Text('Recuperar contraseña', style: TextStyle(color: Colors.blue)),
                ),
                Text('|', style: TextStyle(color: Colors.blue)),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text('Sign Up', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
