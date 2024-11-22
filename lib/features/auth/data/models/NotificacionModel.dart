class NotificacionModel {
  final int id;
  final String titulo;
  final String descripcion;
  final String fechaGeneracion;
  final String fechaVisualizacion;
  final int usuarioId;

  NotificacionModel({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.fechaGeneracion,
    required this.fechaVisualizacion,
    required this.usuarioId,
  });

  factory NotificacionModel.fromJson(Map<String, dynamic> json) {
    return NotificacionModel(
      id: json['id'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      fechaGeneracion: json['fechaGeneracion'],
      fechaVisualizacion: json['fechaVisualizacion'],
      usuarioId: json['usuarioId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'fechaGeneracion': fechaGeneracion,
      'fechaVisualizacion': fechaVisualizacion,
      'usuarioId': usuarioId,
    };
  }
}
