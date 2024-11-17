import 'package:app/features/auth/data/models/actividades/ActividadModel.dart';

import '../api/NoticiaService.dart';
import '../models/NoticiaModel.dart';

class NoticiaRepository {
  final NoticiaService _noticiaService = NoticiaService();

  Future<int> obtenerActividadId(int actividadId) async {
    return await _noticiaService.obtenerActividadId(actividadId);
  }

  //Metodo para crear una noticia
  Future<void> crearNoticia(NoticiaModel noticia) async {
    try {
      await _noticiaService.crearNoticia(noticia);
      print('Noticia creada con exito en el repositorio');
    } catch (e) {
      throw Exception('Error al crear la noticia: $e');
    }
  }

  //Metodo para listar todas las noticias
  Future<List<NoticiaModel>> listarTodasLasNoticias() async {
    try {
      final noticiasJson = await _noticiaService.listarTodasLasNoticias();
      return noticiasJson.map<NoticiaModel>((json) => NoticiaModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error al listar las noticias: $e');
    }
  }
}