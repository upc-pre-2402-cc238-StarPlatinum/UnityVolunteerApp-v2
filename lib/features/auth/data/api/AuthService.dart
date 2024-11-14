import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/UserRegisterModel.dart';
import '../models/LoginRequestModel.dart';


class AuthService {

  final String baseUrl = 'https://backend-movil-production.up.railway.app';

  // Registro de usuario
  Future<Map<String, dynamic>> registerUser(UserRegisterModel user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/usuarios/registro'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );


    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al registrar usuario');
    }
  }

  // Login de usuario
  Future<Map<String, dynamic>> loginUser(LoginModel userLogin) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/usuarios/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userLogin.toJson()),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      throw Exception('Correo o contraseña incorrectos');
    } else {
      throw Exception('Error al iniciar sesión');
    }
  }

//actualizar datos de la organización
  Future<void> updateOrganizacionData(int usuarioId, String nombreOrganizacion, String tipoOrganizacion, String sitioWeb) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/usuarios/organizaciones/$usuarioId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'nombreOrganizacion': nombreOrganizacion,
        'tipoOrganizacion': tipoOrganizacion,
        'sitioWeb': sitioWeb,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      print('Datos de la organización guardados correctamente');
    } else {
      throw Exception('Error al guardar datos de la organización');
    }
  }

  //actualizar datos del voluntario
  Future<void> updateVoluntarioData(int usuarioId, String intereses, String experiencia, String disponibilidad) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/usuarios/voluntarios/$usuarioId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "intereses": intereses,
        "experiencia": experiencia,
        "disponibilidad": disponibilidad,
      }),
    );

    if (response.statusCode == 200) {
      print('Datos del voluntario guardados correctamente');
    } else {
      throw Exception('Error al guardar datos del voluntario');
    }
  }

  // obtener datos de perfil de voluntario
  Future<Map<String, dynamic>> getVoluntarioData(int usuarioId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/usuarios/PerfilVoluntario/$usuarioId'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener datos del voluntario');
    }
  }
  // Obtener perfil de la organización
  Future<Map<String, dynamic>> getOrganizacionData(int usuarioId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/usuarios/PerfilOrganizacion/$usuarioId'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener el perfil de la organización');
    }
  }



}
