class VoluntarioInscrito {
  final int id;
  final String nombre;
  final String correo;
  final String telefono;
  final String intereses;
  final String experiencia;
  final String disponibilidad;
  final int puntuacion;

  VoluntarioInscrito({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.telefono,
    required this.intereses,
    required this.experiencia,
    required this.disponibilidad,
    required this.puntuacion,
  }) {
    print("VoluntarioInscrito creado: $nombre");
  }

  factory VoluntarioInscrito.fromJson(Map<String, dynamic> json) {
    return VoluntarioInscrito(
      id: json['id'],
      nombre: json['nombre'],
      correo: json['correo'],
      telefono: json['telefono'],
      intereses: json['intereses'],
      experiencia: json['experiencia'],
      disponibilidad: json['disponibilidad'],
      puntuacion: json['puntuacion'],
    );
  }
}
