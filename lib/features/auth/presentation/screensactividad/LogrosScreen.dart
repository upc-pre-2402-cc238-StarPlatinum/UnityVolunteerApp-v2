import 'package:flutter/material.dart';

class LogrosScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chocolatada Colegio'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            // Duración de la actividad
            Text('Duración de la actividad', style: TextStyle(fontSize: 18)),
            Text('4 horas', style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 16),
            // Número de días
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: Text('1', style: TextStyle(color: Colors.white, fontSize: 40)),
            ),
            SizedBox(height: 8),
            Text('Día', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            // Botón de finalizar
            ElevatedButton(
              onPressed: () {
                // Acción para finalizar actividad
              },
              child: Text('Finalizar'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                backgroundColor: Colors.orange, // Color de fondo del botón
              ),
            ),
            SizedBox(height: 16),
            // Puntos obtenidos
            Text('Puntos obtenidos:', style: TextStyle(fontSize: 18)),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: Text('20', style: TextStyle(color: Colors.white, fontSize: 40)),
            ),
            SizedBox(height: 8),
            Text('puntos', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            // Subir foto de la actividad
            Text('Foto de la actividad: (opcional)', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                // Lógica para subir la imagen
              },
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload, size: 50, color: Colors.grey),
                    Text('subir', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
