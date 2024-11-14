class VoluntarioModel {
  final int usuarioId;
  final String intereses;
  final String experiencia;
  final String disponibilidad;

  VoluntarioModel({
    required this.usuarioId,
    required this.intereses,
    required this.experiencia,
    required this.disponibilidad,
  });

  // Convertir de JSON a modelo de datos
  factory VoluntarioModel.fromJson(Map<String, dynamic> json) {
    return VoluntarioModel(
      usuarioId: json['usuarioId'],
      intereses: json['intereses'],
      experiencia: json['experiencia'],
      disponibilidad: json['disponibilidad'],
    );
  }

  // Convertir el modelo a JSON para enviar al API
  Map<String, dynamic> toJson() {
    return {
      'usuarioId': usuarioId,
      'intereses': intereses,
      'experiencia': experiencia,
      'disponibilidad': disponibilidad,
    };
  }
}
