import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/NoticiaModel.dart';

class NoticiaService {
  final String baseUrl = 'https:';
  
  //Metodo para obtener la actividadId
  Future<int> obtenerActividadId(int actividadId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/actividades/$actividadId'),
    );

    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['id'];
    } else {
      throw Exception('Error al obtener la actividad relacionada');
    }
  }

  //Metodo para crear una noticia
  Future<void> crearNoticia(NoticiaModel noticia) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/noticias/crear'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(noticia.toJson())
    );

    if(response.statusCode == 201) {
      print('Noticia creada con exito');
    } else {
      throw Exception('Error al crear la noticia');
    }
  }

  //Metodo para listar todas las noticias
  Future<List<Map<String, dynamic>>> listarTodasLasNoticias() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/noticias/listar'),
    );

    if(response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Error al listar las noticas');
    }
  }
}