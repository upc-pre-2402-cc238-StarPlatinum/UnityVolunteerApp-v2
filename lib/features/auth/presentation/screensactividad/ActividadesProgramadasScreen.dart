import 'package:flutter/material.dart';
import '../../data/models/actividades/ActividadModel.dart';

class ActividadesProgramadasScreen extends StatelessWidget {
  final List<ActividadModel> actividadesProgramadas;

  ActividadesProgramadasScreen({required this.actividadesProgramadas}) {
    print('Actividades programadas recibidas en pantalla: $actividadesProgramadas');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis Actividades Programadas',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF3894B6),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: actividadesProgramadas.isNotEmpty
          ? ListView.builder(
        itemCount: actividadesProgramadas.length,
        itemBuilder: (context, index) {
          final actividad = actividadesProgramadas[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    actividad.nombre,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    actividad.descripcion,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF666666),
                    ),
                  ),
                  SizedBox(height: 12),
                  Divider(color: Colors.grey[300]),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Color(0xFF3894B6), size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Fecha y Hora: ${actividad.fecha} - ${actividad.hora}",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Color(0xFF3894B6), size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Lugar: ${actividad.lugar}",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Color(0xFF3894B6), size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Duración: ${actividad.duracion} horas",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.group, color: Color(0xFF3894B6), size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Inscritos: ${actividad.totalPersonasInscritas} / ${actividad.personasMaximo}",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      )
          : Center(
        child: Text(
          'No tienes actividades programadas',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
