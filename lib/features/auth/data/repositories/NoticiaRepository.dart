import 'package:app/features/auth/data/models/actividades/ActividadModel.dart';

import '../api/NoticiaService.dart';
import '../models/NoticiaModel.dart';

class NoticiaRepository {
  final NoticiaService _noticiaService = NoticiaService();

  //Metodo para obtener el organizacionId usando el usuarioId
  Future<int> obtenerOrganizacionId(int usuarioId) async {
    return await _noticiaService.obtenerOrganizacionId(usuarioId);
  }

  //Metodo para crear una noticia
  Future<void> crearNoticia(NoticiaModel noticia) async {
    try {
      await _noticiaService.crearNoticia(noticia);
      print('Noticia creada con exito en el repositorio');
    } catch(e) {
      throw Exception('Error al crear noticia: $e');
    }
  }

  //Metodo para listar noticias solo de la organizacion que las publico
  Future<List<NoticiaModel>> listarNoticiasPorOrganizacion(int organizacionId) async {
    try {
      final noticiasJson = await _noticiaService.listarNoticiasPorOrganizacion(organizacionId);
      return noticiasJson.map<NoticiaModel>((json) => NoticiaModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error al listar las noticias publicadas por la organizacion: $e');
    }
  }

  //Metodo para eliminar una noticia
  Future<void> eliminarNoticia(int noticiaId) async {
    try {
      await _noticiaService.eliminarNoticia(noticiaId);
      print('Noticia eliminada con exito');
    } catch (e) {
      throw Exception('Error al eliminar la noticia: $e');
    }
  }

  //Metodo para listar las noticias
  Future<List<NoticiaModel>> listarTodasLasNoticias() async {
    try {
      final noticiasJson = await _noticiaService.listarTodasLasNoticias();
      return noticiasJson.map<NoticiaModel>((json) => NoticiaModel.fromJson(json)).toList();
    } catch(e) {
      throw Exception('Error al listar las noticias: $e');
    }
  }
}