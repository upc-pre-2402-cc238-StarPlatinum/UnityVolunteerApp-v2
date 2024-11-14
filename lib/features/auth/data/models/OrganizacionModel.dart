class OrganizacionModel {
  final int usuarioId;
  final String nombreOrganizacion;
  final String tipoOrganizacion;
  final String sitioWeb;

  OrganizacionModel({
    required this.usuarioId,
    required this.nombreOrganizacion,
    required this.tipoOrganizacion,
    required this.sitioWeb,
  });

  factory OrganizacionModel.fromJson(Map<String, dynamic> json) {
    return OrganizacionModel(
      usuarioId: json['usuarioId'],
      nombreOrganizacion: json['nombreOrganizacion'],
      tipoOrganizacion: json['tipoOrganizacion'],
      sitioWeb: json['sitioWeb'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'usuarioId': usuarioId,
      'nombreOrganizacion': nombreOrganizacion,
      'tipoOrganizacion': tipoOrganizacion,
      'sitioWeb': sitioWeb,
    };
  }
}
