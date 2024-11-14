import 'package:flutter/material.dart';
import '../../data/models/PerfilOrganizacionModel.dart';
import '../../data/repositories/AuthRepository.dart';

class PerfilOrganizacionScreen extends StatefulWidget {
  final int usuarioId;

  PerfilOrganizacionScreen({required this.usuarioId});

  @override
  _PerfilOrganizacionScreenState createState() => _PerfilOrganizacionScreenState();
}

class _PerfilOrganizacionScreenState extends State<PerfilOrganizacionScreen> {
  late Future<PerfilOrganizacionModel> _perfilFuture;

  @override
  void initState() {
    super.initState();
    _perfilFuture = _getPerfilOrganizacion();
  }

  Future<PerfilOrganizacionModel> _getPerfilOrganizacion() async {
    AuthRepository authRepository = AuthRepository();
    final perfilData = await authRepository.getOrganizacionData(widget.usuarioId);
    return PerfilOrganizacionModel.fromJson(perfilData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mi Perfil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF3894B6),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<PerfilOrganizacionModel>(
        future: _perfilFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar los datos'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No se encontraron datos del perfil'));
          }

          final perfil = snapshot.data!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  child: Icon(Icons.business, size: 60, color: Color(0xFFFF6A00)),
                ),
                SizedBox(height: 10),
                TextButton.icon(
                  onPressed: () {
                  },
                  icon: Icon(Icons.edit, color: Color(0xFFFF6A00)),
                  label: Text('Modificar foto', style: TextStyle(color: Color(0xFFFF6A00))),
                ),
                SizedBox(height: 20),

                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Datos de la Organización', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Divider(color: Colors.grey),
                        SizedBox(height: 10),
                        _buildPersonalInfoRow(Icons.business, 'Nombre Organización', perfil.nombreOrganizacion),
                        SizedBox(height: 10),
                        _buildPersonalInfoRow(Icons.category, 'Tipo Organización', perfil.tipoOrganizacion),
                        SizedBox(height: 10),
                        _buildPersonalInfoRow(Icons.web, 'Sitio Web', perfil.sitioWeb),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Datos del contacto
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Datos del Contacto', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Divider(color: Colors.grey),
                        SizedBox(height: 10),
                        _buildPersonalInfoRow(Icons.person, 'Nombre', perfil.nombre),
                        SizedBox(height: 10),
                        _buildPersonalInfoRow(Icons.person_outline, 'Apellido', perfil.apellido),
                        SizedBox(height: 10),
                        _buildPersonalInfoRow(Icons.email, 'Correo', perfil.correo),
                        SizedBox(height: 10),
                        _buildPersonalInfoRow(Icons.phone, 'Teléfono', perfil.telefono),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Tarjeta del Plan Actual
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Plan Actual', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Divider(color: Colors.grey),
                        SizedBox(height: 10),
                        Text('Plan: Premium', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            // Acción para cambiar el plan
                          },
                          child: Text('Cambiar Plan', style: TextStyle(color: Color(0xFFFF6A00))),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPersonalInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Color(0xFFFF6A00)),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            '$label: $value',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
