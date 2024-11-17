import '../api/AuthService.dart';
import '../models/LoginRequestModel.dart';
import '../models/UserRegisterModel.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  Future<Map<String, dynamic>> registerUser(UserRegisterModel user) async {
    return await _authService.registerUser(user);
  }

  // Login de usuario
  Future<Map<String, dynamic>> loginUser(LoginModel userLogin) async {
    return await _authService.loginUser(
        userLogin); // Retornar la respuesta del login
  }

  //actualizar datos de la organización
  Future<void> saveOrganizacionData(int usuarioId, String nombreOrganizacion,
      String tipoOrganizacion, String sitioWeb) async {
    return await _authService.updateOrganizacionData(
        usuarioId, nombreOrganizacion, tipoOrganizacion, sitioWeb);
  }

  //actualizar datos del voluntario

  Future<void> saveVoluntarioData(int usuarioId, String intereses,
      String experiencia, String disponibilidad, int puntuacion) async {
    return await _authService.updateVoluntarioData(
        usuarioId, intereses, experiencia, disponibilidad,puntuacion);
  }

  // Obtener perfil del voluntario
  Future<Map<String, dynamic>> getVoluntarioData(int usuarioId) async {
    return await _authService.getVoluntarioData(usuarioId);
  }

  // Obtener perfil de la organización
  Future<Map<String, dynamic>> getOrganizacionData(int usuarioId) async {
    return await _authService.getOrganizacionData(usuarioId);
  }
}





