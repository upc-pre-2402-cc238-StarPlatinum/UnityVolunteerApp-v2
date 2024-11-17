import 'package:flutter/material.dart';

class NotificacionVoluntarioScreen extends StatelessWidget {
  final List<String> notificaciones;

  NotificacionVoluntarioScreen({required this.notificaciones}) {
    print('Notificaciones recibidas en pantalla: $notificaciones');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis Notificaciones',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF3894B6),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: notificaciones.isNotEmpty
          ? ListView.builder(
        itemCount: notificaciones.length,
        itemBuilder: (context, index) {
          final notificacion = notificaciones[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.notifications,
                    color: Colors.green,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      notificacion,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )
          : Center(
        child: Text(
          'No tienes notificaciones aún.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
