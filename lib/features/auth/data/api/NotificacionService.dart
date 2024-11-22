import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/NotificacionModel.dart';

class NotificacionService {
  final String baseUrl = 'http://192.168.18.64:8080';

  // Método para crear una notificación
  // Método para crear una notificación
  Future<void> crearNotificacion(String titulo, String descripcion, int usuarioId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/notificacion/Registro'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'titulo': titulo,
        'descripcion': descripcion,
        'fechaGeneracion': DateTime.now().toIso8601String(),
        'fechaVisualizacion': DateTime.now().toIso8601String(),
        'userid': usuarioId,
      }),
    );

    if (response.statusCode == 200) {
      print('Notificación creada exitosamente');
    } else {
      throw Exception('Error al crear la notificación');
    }
  }

  // Método para obtener notificaciones por usuario
  Future<List<Map<String, dynamic>>> obtenerNotificaciones(int usuarioId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/notificacion/usuario/$usuarioId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener las notificaciones');
    }
  }

  // Método para eliminar una notificación por ID
  Future<void> eliminarNotificacion(int notificacionId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/notificacion/eliminar/$notificacionId'),
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      print('Notificación eliminada con éxito');
    } else {
      throw Exception('Error al eliminar la notificación');
    }
  }
}
