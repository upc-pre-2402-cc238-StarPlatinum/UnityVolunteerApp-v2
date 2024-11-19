import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/NoticiaModel.dart';

class NoticiaService {
  final String baseUrl = 'http://192.168.1.2:8080';
  
  //Metodo para obtener el organizacionId usando el usuarioId
  Future<int> obtenerOrganizacionId(int usuarioId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/usuarios/organizaciones/$usuarioId'),
    );
    
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['id'];
    } else {
      throw Exception('Error al obtener el perfil de organizacion');
    }
  }
  
  //Metodo para crear una noticia
  Future<void> crearNoticia(NoticiaModel noticia) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/noticias/organizacion/crear'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(noticia.toJson()),
    );

    if(response.statusCode == 201) {
      print('Noticia creada exitosamente');
    } else {
      throw Exception('Error al crear la noticia');
    }
  }

  //Metodo para listar las noticias
  Future<List<Map<String, dynamic>>> listarTodasLasNoticias() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/noticias/listar'),
    );

    if(response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Error al listar las noticias');
    }
  }
}