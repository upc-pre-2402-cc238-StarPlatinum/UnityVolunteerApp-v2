class LoginModel {
  final String correo;
  final String contrasena;

  LoginModel({
    required this.correo,
    required this.contrasena,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      correo: json['correo'],
      contrasena: json['contrasena'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'correo': correo,
      'contrasena': contrasena,
    };
  }
}
