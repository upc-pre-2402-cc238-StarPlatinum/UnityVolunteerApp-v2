// import 'package:flutter/material.dart';
// import '../screensactividad/ActividadesProgramadasScreen.dart';
// import '../screensactividad/BuscarActividadesScreen.dart';
// import '../screensactividad/NotificacionVoluntarioScreen.dart';
// import 'InicioVoluntarioScreen.dart';
// import 'PerfilVoluntarioScreen.dart';
//
// import '../../data/models/actividades/ActividadModel.dart';
// import '../../data/repositories/ActividadRepository.dart';
//
// class ScreenHomeVoluntario extends StatefulWidget {
//   final String nombre;
//   final int usuarioId;
//
//   ScreenHomeVoluntario({required this.nombre, required this.usuarioId});
//
//   @override
//   _HomeVoluntarioState createState() => _HomeVoluntarioState();
// }
//
// class _HomeVoluntarioState extends State<ScreenHomeVoluntario> {
//   int _selectedIndex = 0;
//   List<ActividadModel> _actividadesProgramadas = [];
//   final _actividadRepository = ActividadRepository();
//
//   late List<Widget> _Screens;
//
//   @override
//   void initState() {
//     super.initState();
//     _Screens = [
//       InicioVoluntarioScreen(nombre: widget.nombre),
//       BuscarActividadesScreen(usuarioId: widget.usuarioId),
//       ActividadesProgramadasScreen(actividadesProgramadas: _actividadesProgramadas),
//       NotificacionVoluntarioScreen(notificaciones: List<String>),
//       PerfilVoluntarioScreen(usuarioId: widget.usuarioId),
//     ];
//   }
//
//   Future<void> _fetchActividadesInscritas() async {
//     try {
//       final voluntarioId = await _actividadRepository.obtenerVoluntarioId(widget.usuarioId);
//       final actividades = await _actividadRepository.listarActividadesInscritas(voluntarioId);
//
//       print('Actividades inscritas recibidas: $actividades'); // Debug
//
//       setState(() {
//         _actividadesProgramadas = actividades;
//         _Screens = [
//           _inicioScreen(),
//           BuscarActividadesScreen(usuarioId: widget.usuarioId),
//           ActividadesProgramadasScreen(actividadesProgramadas: _actividadesProgramadas),
//           Center(child: Text('Notificaciones')),
//           PerfilVoluntarioScreen(usuarioId: widget.usuarioId),
//         ];
//       });
//     } catch (e) {
//       print('Error al obtener actividades inscritas: $e');
//     }
//   }
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       if (_selectedIndex == 2) {
//         _fetchActividadesInscritas().then((_) {
//           setState(() {});
//         });
//       }
//     });
//   }
//
//   Widget _inicioScreen() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           SizedBox(height: 20),
//           Text(
//             '¡Bienvenido, ${widget.nombre}!',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _Screens[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Inicio',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Actividades',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_today),
//             label: 'Programadas',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             label: 'Notificaciones',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Perfil',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Color(0xFF3894B6),
//         unselectedItemColor: Colors.grey,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../screensactividad/ActividadesProgramadasScreen.dart';
import '../screensactividad/BuscarActividadesScreen.dart';
import '../screensactividad/NotificacionVoluntarioScreen.dart';
import 'InicioVoluntarioScreen.dart';
import 'PerfilVoluntarioScreen.dart';

import '../../data/models/actividades/ActividadModel.dart';
import '../../data/repositories/ActividadRepository.dart';

class ScreenHomeVoluntario extends StatefulWidget {
  final String nombre;
  final int usuarioId;

  ScreenHomeVoluntario({required this.nombre, required this.usuarioId, Key? key}) : super(key: key);

  @override
  _ScreenHomeVoluntarioState createState() => _ScreenHomeVoluntarioState();
}

class _ScreenHomeVoluntarioState extends State<ScreenHomeVoluntario> {
  int _selectedIndex = 0;
  List<ActividadModel> _actividadesProgramadas = [];
  List<String> _notificaciones = []; // Lista de notificaciones

  final _actividadRepository = ActividadRepository();

  @override
  void initState() {
    super.initState();
    _fetchActividadesInscritas();
  }

  Future<void> _fetchActividadesInscritas() async {
    try {
      final voluntarioId = await _actividadRepository.obtenerVoluntarioId(widget.usuarioId);
      final actividades = await _actividadRepository.listarActividadesInscritas(voluntarioId);

      setState(() {
        _actividadesProgramadas = actividades;
      });
    } catch (e) {
      print('Error al obtener actividades inscritas: $e');
    }
  }

  void agregarNotificacion(String mensaje) {
    setState(() {
      _notificaciones.add(mensaje);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _Screens = [
      InicioVoluntarioScreen(nombre: widget.nombre),
      BuscarActividadesScreen(usuarioId: widget.usuarioId),
      ActividadesProgramadasScreen(actividadesProgramadas: _actividadesProgramadas),
      NotificacionVoluntarioScreen(notificaciones: _notificaciones), // Pasamos las notificaciones
      PerfilVoluntarioScreen(usuarioId: widget.usuarioId),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _Screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Actividades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Programadas',
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
