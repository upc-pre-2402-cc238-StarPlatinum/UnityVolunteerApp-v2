import 'package:flutter/material.dart';
import '../../data/models/actividades/ActividadModel.dart';
import '../../data/models/actividades/VoluntarioInscrito.dart';
import '../../data/repositories/ActividadRepository.dart';

class VoluntariosPorActividadScreen extends StatefulWidget {
  final int organizacionId;

  VoluntariosPorActividadScreen({required this.organizacionId});

  @override
  _VoluntariosPorActividadScreenState createState() => _VoluntariosPorActividadScreenState();
}

class _VoluntariosPorActividadScreenState extends State<VoluntariosPorActividadScreen> {
  final _actividadRepository = ActividadRepository();
  late Future<List<ActividadModel>> _actividadesFuture;

  @override
  void initState() {
    super.initState();
    _actividadesFuture = _actividadRepository.listarActividadesPorOrganizacion(widget.organizacionId);
  }

  Future<List<VoluntarioInscrito>> _fetchVoluntarios(int actividadId) async {
    return await _actividadRepository.listarVoluntariosPorActividad(actividadId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Voluntarios Inscritos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF3894B6),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<ActividadModel>>(
              future: _actividadesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red)));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No hay actividades.'));
                }

                final actividades = snapshot.data!;
                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: actividades.length,
                  itemBuilder: (context, index) {
                    final actividad = actividades[index];

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              actividad.nombre,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                            ),
                            SizedBox(height: 10),
                            FutureBuilder<List<VoluntarioInscrito>>(
                              future: _fetchVoluntarios(actividad.id),
                              builder: (context, voluntariosSnapshot) {
                                if (voluntariosSnapshot.connectionState == ConnectionState.waiting) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                  );
                                } else if (voluntariosSnapshot.hasError) {
                                  return Center(child: Text('Error: ${voluntariosSnapshot.error}', style: TextStyle(color: Colors.red)));
                                } else if (!voluntariosSnapshot.hasData || voluntariosSnapshot.data!.isEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Center(child: Text('No hay voluntarios inscritos.')),
                                  );
                                }

                                final voluntarios = voluntariosSnapshot.data!;
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columnSpacing: 16,
                                    headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey[200]!),
                                    columns: [
                                      DataColumn(label: Text('N°', style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Nombre', style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Correo', style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Teléfono', style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Intereses', style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Experiencia', style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Disponibilidad', style: TextStyle(fontWeight: FontWeight.bold))),
                                    ],
                                    rows: List<DataRow>.generate(
                                      voluntarios.length,
                                          (index) {
                                        final voluntario = voluntarios[index];
                                        return DataRow(cells: [
                                          DataCell(Text((index + 1).toString())),
                                          DataCell(Text(voluntario.nombre)),
                                          DataCell(Text(voluntario.correo)),
                                          DataCell(Text(voluntario.telefono)),
                                          DataCell(Text(voluntario.intereses)),
                                          DataCell(Text(voluntario.experiencia)),
                                          DataCell(Text(voluntario.disponibilidad)),
                                        ]);
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
