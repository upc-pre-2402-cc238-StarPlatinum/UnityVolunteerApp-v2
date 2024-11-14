class UserRegisterModel {
  final String correo;
  final String nombre;
  final String apellido;
  final String telefono;
  final String contrasena;
  final String tipoUsuario;

  UserRegisterModel({
    required this.correo,
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.contrasena,
    required this.tipoUsuario,
  });

  // Convertir de JSON a modelo de datos
  factory UserRegisterModel.fromJson(Map<String, dynamic> json) {
    return UserRegisterModel(
      correo: json['correo'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      telefono: json['telefono'],
      contrasena: json['contrasena'],
      tipoUsuario: json['tipoUsuario'],
    );
  }

  // Convertir el modelo a JSON para enviar al API
  Map<String, dynamic> toJson() {
    return {
      'correo': correo,
      'nombre': nombre,
      'apellido': apellido,
      'telefono': telefono,
      'contrasena': contrasena,
      'tipoUsuario': tipoUsuario,
    };
  }
}
