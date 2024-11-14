
class PerfilVoluntarioModel {
  final String correo;
  final String nombre;
  final String apellido;
  final String telefono;
  final String intereses;
  final String experiencia;
  final String disponibilidad;

  PerfilVoluntarioModel({
    required this.correo,
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.intereses,
    required this.experiencia,
    required this.disponibilidad,
  });

  factory PerfilVoluntarioModel.fromJson(Map<String, dynamic> json) {
    return PerfilVoluntarioModel(
      correo: json['correo'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      telefono: json['telefono'],
      intereses: json['intereses'],
      experiencia: json['experiencia'],
      disponibilidad: json['disponibilidad'],
    );
  }
}
