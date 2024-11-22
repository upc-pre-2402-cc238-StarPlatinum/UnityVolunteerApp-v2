import 'package:flutter/material.dart';
import '../../data/repositories/ActividadRepository.dart';

class NotificacionVoluntarioScreen extends StatefulWidget {
  final int usuarioId;

  NotificacionVoluntarioScreen({required this.usuarioId});

  @override
  _NotificacionVoluntarioScreenState createState() => _NotificacionVoluntarioScreenState();
}

class _NotificacionVoluntarioScreenState extends State<NotificacionVoluntarioScreen> {
  final _actividadRepository = ActividadRepository();
  List<Map<String, dynamic>> _notificaciones = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNotificaciones();
  }

  Future<void> _fetchNotificaciones() async {
    try {
      final notificaciones = await _actividadRepository.obtenerNotificaciones(widget.usuarioId);
      setState(() {
        _notificaciones = notificaciones;
        _isLoading = false;
      });
    } catch (e) {
      print('Error al obtener notificaciones: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis notificaciones',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF3894B6),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : _notificaciones.isNotEmpty
          ? ListView.builder(
        itemCount: _notificaciones.length,
        itemBuilder: (context, index) {
          final notificacion = _notificaciones[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: ListTile(
              title: Text(
                notificacion['titulo'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(notificacion['descripcion']),
            ),
          );
        },
      )
          : Center(
        child: Text(
          'No tienes notificaciones',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}

