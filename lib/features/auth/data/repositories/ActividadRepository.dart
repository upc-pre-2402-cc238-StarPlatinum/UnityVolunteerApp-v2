import '../api/ActividadService.dart';
import '../models/actividades/ActividadModel.dart';
import '../models/actividades/VoluntarioInscrito.dart';

class ActividadRepository {
  final ActividadService _actividadService = ActividadService();

  Future<int> obtenerOrganizacionId(int usuarioId) async {
    return await _actividadService.obtenerOrganizacionId(usuarioId);
  }

  Future<void> actualizarActividad(int actividadId, ActividadModel actividad) {
    return _actividadService.actualizarActividad(actividadId, actividad);
  }

  // Método para obtener el voluntarioId usando el usuarioId
  Future<int> obtenerVoluntarioId(int usuarioId) async {
    return await _actividadService.obtenerVoluntarioId(usuarioId);
  }

  // Método para crear una actividad
  Future<void> crearActividad(ActividadModel actividad) async {
    try {
      await _actividadService.crearActividad(actividad);
      print('Actividad creada con éxito en el repositorio');
    } catch (e) {
      throw Exception('Error al crear actividad: $e');
    }
  }

  // Método para listar actividades solo de la organización especificada
  Future<List<ActividadModel>> listarActividadesPorOrganizacion(int organizacionId) async {
    try {
      final actividadesJson = await _actividadService.listarActividadesPorOrganizacion(organizacionId);
      return actividadesJson.map<ActividadModel>((json) => ActividadModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error al listar las actividades de la organización: $e');
    }
  }

  // Método para eliminar una actividad
  Future<void> eliminarActividad(int actividadId) async {
    try {
      await _actividadService.eliminarActividad(actividadId);
      print('Actividad eliminada con éxito');
    } catch (e) {
      throw Exception('Error al eliminar la actividad: $e');
    }
  }



  // Método para listar todas las actividades
  Future<List<ActividadModel>> listarTodasLasActividades() async {
    try {
      final actividadesJson = await _actividadService.listarTodasLasActividades();
      return actividadesJson.map<ActividadModel>((json) => ActividadModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error al listar todas las actividades: $e');
    }
  }

  // Método para participar en una actividad
  Future<void> participarEnActividad(int actividadId, int voluntarioId) async {
    try {
      await _actividadService.participarEnActividad(actividadId, voluntarioId);
      print('Participación en actividad registrada con éxito');
    } catch (e) {
      throw Exception('Error al participar en la actividad: $e');
    }
  }

  // Método para obtener detalles completos de la organización
  Future<Map<String, dynamic>> obtenerDetallesOrganizacion(int usuarioId) async {
    return await _actividadService.obtenerDetallesOrganizacion(usuarioId);
  }

// método para obtener todas las actividades en las que el voluntario está inscrito
  Future<List<ActividadModel>> listarActividadesInscritas(int voluntarioId) async {
    try {
      final actividadesJson = await _actividadService.listarActividadesInscritas(voluntarioId);
      return actividadesJson.map<ActividadModel>((json) => ActividadModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error al listar las actividades inscritas: $e');
    }
  }

  // Método para listar voluntarios inscritos en una actividad

  Future<List<VoluntarioInscrito>> listarVoluntariosPorActividad(int actividadId) async {
    try {
      final voluntariosJson = await _actividadService.listarVoluntariosPorActividad(actividadId);
      final voluntarios = voluntariosJson.map((json) => VoluntarioInscrito.fromJson(json)).toList();
      print("Voluntarios mapeados en ActividadRepository: $voluntarios"); // Debug
      return voluntarios;
    } catch (e) {
      print("Error en listarVoluntariosPorActividad: $e");
      throw Exception('Error al listar los voluntarios inscritos en la actividad: $e');
    }
  }



}

