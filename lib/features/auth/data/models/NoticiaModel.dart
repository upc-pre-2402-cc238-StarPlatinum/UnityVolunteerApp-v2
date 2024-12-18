class NoticiaModel {
  final int id;
  final String titulo;
  final String descripcion;
  final String? imagenPortada;
  final String fechaPublicacion;
  final int organizacionId;

  NoticiaModel({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.imagenPortada,
    required this.fechaPublicacion,
    required this.organizacionId,
  });

  factory NoticiaModel.fromJson(Map<String, dynamic> json) {
    return NoticiaModel(
        id: json['id'],
        titulo: json['titulo'],
        descripcion: json['descripcion'],
        imagenPortada: json['imagenPortada'],
        fechaPublicacion: json['fechaPublicacion'],
        organizacionId: json['organizacionId']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'imagenPortada': imagenPortada,
      'fechaPublicacion': fechaPublicacion,
      'organizacionId': organizacionId
    };
  }
}