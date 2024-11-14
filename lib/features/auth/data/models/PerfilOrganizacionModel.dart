class PerfilOrganizacionModel {
  final String correo;
  final String nombre;
  final String apellido;
  final String telefono;
  final String nombreOrganizacion;
  final String tipoOrganizacion;
  final String sitioWeb;

  PerfilOrganizacionModel({
    required this.correo,
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.nombreOrganizacion,
    required this.tipoOrganizacion,
    required this.sitioWeb,
  });

  // Mapeo del JSON a un objeto PerfilOrganizacionModel
  factory PerfilOrganizacionModel.fromJson(Map<String, dynamic> json) {
    return PerfilOrganizacionModel(
      correo: json['correo'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      telefono: json['telefono'],
      nombreOrganizacion: json['nombreOrganizacion'],
      tipoOrganizacion: json['tipoOrganizacion'],
      sitioWeb: json['sitioWeb'],
    );
  }
}
