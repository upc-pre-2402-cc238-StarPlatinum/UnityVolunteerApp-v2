import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/actividades/ActividadModel.dart';

class ActividadService {
  final String baseUrl = 'http://10.0.2.2:8080';

  // Método para obtener el organizacionId usando el usuarioId
  Future<int> obtenerOrganizacionId(int usuarioId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/usuarios/organizaciones/$usuarioId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['id'];
    } else {
      throw Exception('Error al obtener el perfil de organización');
    }
  }

// Método para obtener el voluntarioId usando el usuarioId
  Future<int> obtenerVoluntarioId(int usuarioId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/usuarios/voluntarios/$usuarioId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['id'];
    } else {
      throw Exception('Error al obtener el perfil de voluntario');
    }
  }

  // Método para crear una actividad
  Future<void> crearActividad(ActividadModel actividad) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/actividades/organizacion/crear'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(actividad.toJson()),
    );

    if (response.statusCode == 201) {
      print('Actividad creada exitosamente');
    } else {
      throw Exception('Error al crear la actividad');
     }
  }

  // Método para listar actividades por organizacionId
  Future<List<Map<String, dynamic>>> listarActividadesPorOrganizacion(int organizacionId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/actividades/organizacion/$organizacionId'),
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Error al listar las actividades de la organización');
    }
  }

  // Método para eliminar una actividad
  Future<void> eliminarActividad(int actividadId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/actividades/organizacion/eliminar/$actividadId'),
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      print('Actividad eliminada exitosamente');
    } else {
      throw Exception('Error al eliminar la actividad');
    }
  }



  // Método para listar todas las actividades
  Future<List<Map<String, dynamic>>> listarTodasLasActividades() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/actividades/listar'),
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Error al listar las actividades');
    }
  }

  // Método para participar en una actividad
  Future<void> participarEnActividad(int actividadId, int voluntarioId) async {
    try{
      final response = await http.post(
        Uri.parse('$baseUrl/api/actividades/voluntario/participar/$actividadId?voluntarioId=$voluntarioId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Participación registrada exitosamente');
      } else {
        throw Exception('Error al registrar la participación');
      }
    }catch(e){
      throw Exception(e);
    }
  }

// Método para obtener detalles completos de la organización
  Future<Map<String, dynamic>> obtenerDetallesOrganizacion(int usuarioId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/usuarios/organizaciones/$usuarioId'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener los detalles de la organización');
    }
  }

// Método para listar actividades inscritas por voluntarioId
  Future<List<Map<String, dynamic>>> listarActividadesInscritas(int voluntarioId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/actividades/voluntario/$voluntarioId'),
    );

    if (response.statusCode == 200) {
      print("Datos recibidos de actividades inscritas: ${response.body}"); //
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Error al listar las actividades inscritas');
    }
  }


  Future<List<Map<String, dynamic>>> listarVoluntariosPorActividad(int actividadId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/actividades/$actividadId/ListarVoluntarios-Actividad'),
    );

    if (response.statusCode == 200) {
      print("Datos de voluntarios recibidos del backend: ${response.body}");
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      print("Error al listar los voluntarios: ${response.statusCode}");
      throw Exception('Error al listar los voluntarios inscritos');
    }
  }



}
