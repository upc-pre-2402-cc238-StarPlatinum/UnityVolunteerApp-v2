import 'package:app/features/auth/data/repositories/AuthRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'LoginScreen.dart';

class OrganizacionScreen extends StatefulWidget {
  final String nombre;
  final int usuarioId;

  OrganizacionScreen({required this.nombre, required this.usuarioId});

  @override
  _OrganizacionScreenState createState() => _OrganizacionScreenState();
}

class _OrganizacionScreenState extends State<OrganizacionScreen> {
  final _nombreOrganizacionController = TextEditingController();
  final _tipoOrganizacionController = TextEditingController();
  final _sitioWebController = TextEditingController();

  final AuthRepository _authRepository = AuthRepository();

  Future<void> _guardarDatosOrganizacion() async {
    try {
      await _authRepository.saveOrganizacionData(
        widget.usuarioId,
        _nombreOrganizacionController.text,
        _tipoOrganizacionController.text,
        _sitioWebController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Datos de la organización guardados exitosamente')),
      );

      // Redirigir a la pantalla de login
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar datos: $e')),
      );
    }
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 60),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.business_outlined,
                  size: 100,
                  color: Color(0xFF3894B6),
                ),
                SizedBox(height: 20),
                Text(
                  '¡Hola, ${widget.nombre}!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Completa los datos de tu organización',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 40),

            _buildTextField('Nombre de la organización', _nombreOrganizacionController),
            SizedBox(height: 20),

            _buildTextField('Tipo de organización', _tipoOrganizacionController),
            SizedBox(height: 20),

            _buildTextField('Sitio web', _sitioWebController),
            SizedBox(height: 40),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF6A00),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _guardarDatosOrganizacion,
              child: Text('Guardar', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[700]),
        filled: true,
        fillColor: Color(0xFFF5F6FA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
