import 'package:flutter/material.dart';
import '../screensactividad/CrearActividadScreen.dart';
import '../screensactividad/NotificacionOrganizacionScreen.dart';
import '../screensactividad/VoluntariosPorActividadScreen.dart';
import 'InicioOrganizacionScreen.dart';
import 'PerfilOrganizacionScreen.dart';
import '../../data/repositories/ActividadRepository.dart';

class ScreenHomeOrganizacion extends StatefulWidget {
  final String nombre;
  final int usuarioId;

  ScreenHomeOrganizacion({required this.nombre, required this.usuarioId});

  @override
  _HomeOrganizacionState createState() => _HomeOrganizacionState();
}

class _HomeOrganizacionState extends State<ScreenHomeOrganizacion> {
  int _selectedIndex = 0;
  final _actividadRepository = ActividadRepository();
  late int _organizacionId;
  List<Widget> _Screens = [];

  @override
  void initState() {
    super.initState();
    _loadOrganizacionId();
  }

  Future<void> _loadOrganizacionId() async {
    try {
      _organizacionId = await _actividadRepository.obtenerOrganizacionId(widget.usuarioId);
      setState(() {
        // Inicializar `_Screens` solo después de obtener `organizacionId`
        _Screens = [
          InicioOrganizacionScreen(nombre: widget.nombre),
          CrearActividadScreen(usuarioId: widget.usuarioId),
          VoluntariosPorActividadScreen(organizacionId: _organizacionId),
          notificacionOrganizacionScreen() ,// Pantalla de notificaciones vacía
          PerfilOrganizacionScreen(usuarioId: widget.usuarioId),
        ];
      });
    } catch (e) {
      print('Error al obtener organizacionId: $e');
    }
  }

  Widget _inicioScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          Text(
            '¡Bienvenido, ${widget.nombre}!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _notificacionesScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          'Pantalla de Notificaciones (Pendiente)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_Screens.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Organización',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF3894B6),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(

      body: _Screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Crear Actividad',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Voluntarios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificaciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF3894B6),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
