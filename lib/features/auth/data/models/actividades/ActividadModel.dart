class ActividadModel {
  final int id;
  final String nombre;
  final String descripcion;
  final String tipo;
  final String lugar;
  final String duracion;
  final String fecha;
  final String hora;
  final int personasMinimo;
  final int personasMaximo;
  final int totalPersonasInscritas;
  final String? nombreOrganizacion;
  final String? sitioWeb;
  final int organizacionId;
  final int puntuationActividad;

  ActividadModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.tipo,
    required this.lugar,
    required this.duracion,
    required this.fecha,
    required this.hora,
    required this.personasMinimo,
    required this.personasMaximo,
    required this.totalPersonasInscritas,
 this.nombreOrganizacion,
 this.sitioWeb,

    required this.organizacionId,
    required this.puntuationActividad,

  });

  factory ActividadModel.fromJson(Map<String, dynamic> json) {
    return ActividadModel(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      tipo: json['tipo'],
      lugar: json['lugar'],
      duracion: json['duracion'],
      fecha: json['fecha'],
      hora: json['hora'],
      personasMinimo: json['personasMinimo'],
      personasMaximo: json['personasMaximo'],
      totalPersonasInscritas: json['totalPersonasInscritas'],
      nombreOrganizacion: json['organizacion']?['nombreOrganizacion'],
      sitioWeb: json['organizacion']?['sitioWeb'],
      organizacionId: json['organizacionId'],
      puntuationActividad: json['puntuationActividad'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'tipo': tipo,
      'lugar': lugar,
      'duracion': duracion,
      'fecha': fecha,
      'hora': hora,
      'personasMinimo': personasMinimo,
      'personasMaximo': personasMaximo,
      'totalPersonasInscritas': totalPersonasInscritas,
      'organizacionId': organizacionId,
      'nombreOrganizacion': nombreOrganizacion,
      'sitioWeb': sitioWeb,
      'puntuationActividad': puntuationActividad,
    };
  }
}
