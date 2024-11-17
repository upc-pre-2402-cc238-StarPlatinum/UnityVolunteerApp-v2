class NoticiaModel {
  final int id;
  final String titulo;
  final String descripcion;
  final String fecha;
  final int actividadId;

  NoticiaModel({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    required this.actividadId,
  });

  factory NoticiaModel.fromJson(Map<String, dynamic> json) {
    return NoticiaModel(
        id: json['id'],
        titulo: json['titulo'],
        descripcion: json['descripcion'],
        fecha: json['fecha'],
        actividadId: json['actividadId']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'fecha': fecha,
      'actividadId': actividadId
    };
  }
}