import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/models/UserRegisterModel.dart';
import '../../data/repositories/AuthRepository.dart';
import 'OrganizacionScreen.dart';
import 'VoluntarioScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _correoController = TextEditingController();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _contrasenaController = TextEditingController();
  String _tipoUsuario = 'VOLUNTARIO';

  final AuthRepository _authRepository = AuthRepository();

  Future<void> _register() async {
    try {
      final user = UserRegisterModel(
        correo: _correoController.text,
        nombre: _nombreController.text,
        apellido: _apellidoController.text,
        telefono: _telefonoController.text,
        contrasena: _contrasenaController.text,
        tipoUsuario: _tipoUsuario,
      );

      final response = await _authRepository.registerUser(user);


      final usuarioId = response['usuarioId'] as int; //

      if (_tipoUsuario == 'VOLUNTARIO') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VoluntarioScreen(
              nombre: user.nombre,
              usuarioId: usuarioId,
            ),
          ),
        );
      } else if (_tipoUsuario == 'ORGANIZACION') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrganizacionScreen(
              nombre: user.nombre,
              usuarioId: usuarioId,
            ),
          ),
        );
      }

      _clearForm();

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en el registro: $e')),
      );
    }
  }

  void _clearForm() {
    _correoController.clear();
    _nombreController.clear();
    _apellidoController.clear();
    _telefonoController.clear();
    _contrasenaController.clear();
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
            // Título
            Text(
              'Registro de Usuario',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),

            TextField(
              controller: _correoController,
              decoration: InputDecoration(
                labelText: 'Correo',
                filled: true,
                fillColor: Color(0xFFF5F6FA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            TextField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                filled: true,
                fillColor: Color(0xFFF5F6FA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Campo de apellido
            TextField(
              controller: _apellidoController,
              decoration: InputDecoration(
                labelText: 'Apellido',
                filled: true,
                fillColor: Color(0xFFF5F6FA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Campo de teléfono
            TextField(
              controller: _telefonoController,
              decoration: InputDecoration(
                labelText: 'Teléfono',
                filled: true,
                fillColor: Color(0xFFF5F6FA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),

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

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  'Tipo de usuario',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6FA),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: DropdownButton<String>(
                    value: _tipoUsuario,
                    onChanged: (String? newValue) {
                      setState(() {
                        _tipoUsuario = newValue!;
                      });
                    },
                    items: <String>['VOLUNTARIO', 'ORGANIZACION']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    isExpanded: true,
                    underline: SizedBox(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Botón de continuar
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF6A00),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _register,
              child: Text(
                'Continuar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
